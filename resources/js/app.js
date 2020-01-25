import Vue from 'vue';
import axios from 'axios';
import { BootstrapVue } from 'bootstrap-vue';
import SalesSummary from './components/SalesSummary';

// Install BootstrapVue
Vue.use(BootstrapVue);

window.axios = axios;
window.axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest';

Vue.component('sales-summary', SalesSummary);

new Vue({
    el: '#app',
});
