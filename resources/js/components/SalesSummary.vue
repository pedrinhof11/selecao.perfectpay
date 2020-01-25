<template>
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="card my-4">
          <div class="card-body">
            <div class="row" v-if="customers" >
              <div class="col-md-6">
                <b-form-select
                    v-model="customerSelected"
                    :options="customers"
                    @input="changeCustomer"
                    value-field="id"
                    text-field="name">
                  <template v-slot:first>
                    <b-form-select-option :value="null">Clientes</b-form-select-option>
                  </template>
                </b-form-select>
              </div>
              <div class="col-md-6">
                <b-input-group>
                  <template v-slot:prepend>
                    <b-input-group-text >Período</b-input-group-text>
                  </template>
                  <b-form-input v-model="period" type="date" @input="changeCustomerDebounce"></b-form-input>
                </b-input-group>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-12">
        <div class="card">
          <div class="card-header">Tabela de Vendas</div>

          <div class="card-body">
            <b-table hover bordered :items="salesTableItems" :fields="salesTablefields" :busy="isLoadingSales" >
              <template v-slot:table-busy>
                <div class="text-center my-2">
                  <b-spinner class="align-middle"></b-spinner>
                  <strong>Loading...</strong>
                </div>
              </template>
              <template v-slot:cell(action)="data" >
                <b-button size="sm" @click="edit(data.item)" variant="outline-secondary">
                  Editar
                </b-button>
              </template>
            </b-table>
          </div>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-md-12">
        <div class="card my-4">
          <div class="card-header">Resultados das Vendas</div>

          <div class="card-body">
            <b-table hover bordered :items="salesResultTableItems" :fields="salesResultTablefields" :busy="isLoadingSalesResult" >

              <template v-slot:table-busy>
                <div class="text-center my-2">
                  <b-spinner class="align-middle"></b-spinner>
                  <strong>Loading...</strong>
                </div>
              </template>

            </b-table>
          </div>
        </div>
      </div>
    </div>
    <sale-edit-form-modal :active.sync="isModalEdit" :sale="saleSelected" @submit="fetchAllData"></sale-edit-form-modal>
  </div>
</template>

<script>
  import toStringCurrency from '../utils/toStringCurrency'
  import convertStatus from '../utils/convertStatus'
  import debounce from 'lodash/debounce'
  import SaleEditFormModal from './SaleEditFormModal'

  export default {
    name: 'SaleSummary',
    components: {
      SaleEditFormModal
    },
    created() {
      this.onCreated()
    },
    data() {
      return {
        isLoadingSales: false,
        isLoadingSalesResult: false,
        customers: null,
        customerSelected: null,
        period: null,
        salesTablefields: [
          { key: 'product', label: 'Produto' },
          { key: 'date', label: 'Data' },
          { key: 'quantity', label: 'Quantidade' },
          { key: 'sale_amount', label: 'Valor' },
          { key: 'action', label: 'Ações' },

        ],
        salesTableItems: null,
        salesResultTablefields: ['status', 'quantidade', 'valorTotal'],
        salesResultTableItems: null,
        changeCustomerDebounce: debounce( this.changeCustomer, 500),

        isModalEdit: false,
        saleSelected: null
      }
    },
    methods: {
      async onCreated() {
        try {
          await Promise.all([this.fetchCustomers(), this.fetchSales(), this.fetchSalesResult()])
        } finally {
        }
      },

      async fetchAllData() {
        try {
          await Promise.all([this.fetchSales(), this.fetchSalesResult()])
        } finally {
        }
      },

      async fetchCustomers() {
        const {data} = await axios.get('/api/customers');
        this.customers = data
      },

      async fetchSales() {
        try {
          this.isLoadingSales = true;
          const {data} = await axios.get('/api/sales', this.makeParams());
          this.salesTableItems = data.map(item => ({
            id: item.id,
            product: item.product.name,
            date: item.date,
            quantity: item.quantity,
            sale_amount: toStringCurrency(item.sale_amount)
          }));
        } finally {
          this.isLoadingSales = false;
        }
      },

      async fetchSalesResult() {
        try {
          this.isLoadingSalesResult = true;
          const {data} = await axios.get('/api/sales/result', this.makeParams());
          this.salesResultTableItems = data.map(item => ({
            status: convertStatus(item.status),
            quantidade: item.quantity,
            valorTotal: toStringCurrency(item.total_amount)
          }))
        } finally {
          this.isLoadingSalesResult = false;
        }
      },

      async changeCustomer () {
        await this.fetchAllData();
      },

      edit(row) {
        this.isModalEdit = true;
        this.saleSelected = row
      },

      makeParams() {
        const params = {};
        if (this.customerSelected) params.customer_id = this.customerSelected;
        if (this.period) params.period = this.period;
        return { params };
      }
    }
  }
</script>
