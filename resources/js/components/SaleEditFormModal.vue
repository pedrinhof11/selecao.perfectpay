<template>
  <b-modal v-model="active" @change="changeActive" centered :title="`Editar venda #${sale && sale.id}`" no-close-on-backdrop>
    <b-form @submit.prevent="onSubmit" @keyup.enter="onSubmit" ref="saleForm">
      <div v-if="products">
        <div class="form-group">
          <b-input-group>
            <template v-slot:prepend>
              <b-input-group-text >Data</b-input-group-text>
            </template>
            <b-form-input v-model="form.date" disabled ></b-form-input>
          </b-input-group>
        </div>

        <div class="form-group">
          <b-input-group>
            <template v-slot:prepend>
              <b-input-group-text >Cliente</b-input-group-text>
            </template>
            <b-form-input v-model="form.customer.name" disabled ></b-form-input>
          </b-input-group>
        </div>

        <div class="form-group">
          <b-input-group>
            <template v-slot:prepend>
              <b-input-group-text >Produto</b-input-group-text>
            </template>
            <b-form-select
              v-model="form.product_id"
              :options="products"
              value-field="id"
              text-field="name"
              @change="changeProductOrQuantityOrDiscount">
            </b-form-select>
          </b-input-group>
        </div>

        <div class="form-group">
          <b-input-group>
            <template v-slot:prepend>
              <b-input-group-text >Quantidade</b-input-group-text>
            </template>
            <b-form-input
              v-model="form.quantity"
              type="number"
              min="1"
              @change="changeProductOrQuantityOrDiscount"
              :class="{ 'is-invalid': this.formErrors && this.formErrors.quantity }"/>
          </b-input-group>
        </div>

        <div class="form-group">
          <b-input-group>
            <template v-slot:prepend>
              <b-input-group-text >Desconto (%)</b-input-group-text>
            </template>
            <b-form-input
              v-model="form.discount"
              type="number"
              min="0" max="100"
              @change="changeProductOrQuantityOrDiscount"
              :class="{ 'is-invalid': this.formErrors && this.formErrors.discount }" />
          </b-input-group>
        </div>

        <div class="form-group">
          <b-input-group>
            <template v-slot:prepend>
              <b-input-group-text >Valor</b-input-group-text>
            </template>
            <b-form-input v-model="form.sale_amount" disabled></b-form-input>
          </b-input-group>
        </div>

        <div class="form-group">
          <b-input-group>
            <template v-slot:prepend>
              <b-input-group-text >Status</b-input-group-text>
            </template>
            <b-form-select
              v-model="form.status"
              :options="statusOptions"
              value-field="value"
              text-field="name">
            </b-form-select>
          </b-input-group>
        </div>
      </div>
    </b-form>

    <template v-slot:modal-footer>
      <b-button variant="outline-secondary" @click.prevent="close">Cancelar</b-button>
      <b-button variant="outline-success" @click.prevent="onSubmit" :disabled="isLoading">Salvar</b-button>
    </template>

  </b-modal>
</template>

<script>

  export default {
    name: "SaleEditForm",
    props: {
      sale: {
        type: Object,
        required: false,
        default: () => false
      },
      active: {
        type: Boolean,
        required: true,
      }
    },

    created () {
      this.onCreated()
    },

    data () {
      return {
        isLoading: false,
        form: {
          customer: {
            name: null
          }
        },
        formErrors: null,
        products: null,
        statusOptions: [
          {value: 'SOLD' , name: "Vendido"},
          {value: 'CANCELED' , name: "Cancelado"},
          {value: 'DEVOLUTION' , name: "Devolução"}
        ]
      }
    },
    methods: {
      async onCreated () {
        await Promise.all([this.fetchProducts()]);
      },

      changeActive (value) {
        this.$emit('update:active', value)
      },

      resetForm () {
        this.form = {
          customer: {
            name: null
          }
        }
        this.formErrors = null
      },

      close () {
        this.resetForm();
        this.changeActive(false)
      },

      async onSubmit (e) {
        try {
          this.isLoading = true;
          await axios.put(`/api/sales/${this.sale.id}`, this.form)
          this.$emit('submit')
          this.close();
        } catch (error) {
          if (error.response.status === 422) {
            this.formErrors = error.response.data.errors
          } else {console.error(error)}
        } finally {
          this.isLoading = false
        }
      },

      async fetchProducts () {
        const { data } = await axios.get('/api/products');
        this.products = data
      },

      changeProductOrQuantityOrDiscount () {
        this.recalculateSaleAmount()
      },

      recalculateSaleAmount () {
        const product = this.products.find(i => i.id === this.form.product_id);
        const quantity = this.form.quantity;
        const discount = product.price * quantity * this.form.discount / 100;

        this.form.sale_amount = product.price * quantity - discount;
      },

      async loadEditMode () {
        if (this.sale) {
          const { data } = await axios.get('/api/sales/' + this.sale.id);
          this.form = data;
        }
      }
    },

    watch: {
      active (newValue) {
        if (newValue) {
          this.loadEditMode()
        }
      }
    }
  }
</script>
