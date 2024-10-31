import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import Toast from "vue-toastification";
import Web3 from "web3/lib"
import "vue-toastification/dist/index.css";
import VueLazyload from "vue-lazyload";
import './quasar'
import vuetify from "./plugins/vuetify"

// vue router
import VueRouter from 'vue-router'
Vue.use(VueRouter)

Vue.config.productionTip = false

Vue.use(Toast, {
    transition: "Vue-Toastification__bounce",
    maxToasts: 20,
    newestOnTop: true
  });

const loadimage = require("@/assets/placeholder.jpg");
const errorimage = require("@/assets/placeholder.jpg");
Vue.use(VueLazyload, {
    preLoad: 1.3,
    error: errorimage,
    loading: loadimage,
    attempt: 2,
  });

Vue.use(vuetify);

new Vue({
    router,
    store,
    beforeCreate() {
        const { ethereum } = window;
        if(ethereum && ethereum.isMetaMask) {
          window.web3 = new Web3(ethereum);
          store.commit('init')
          store.commit('read_diamond')
          store.commit('read_masterchef')
          store.commit('read_jackpot')
          store.commit('read_reward')
          store.commit('read_liquiditygenerator')
          store.commit('read_fantoonnft')
//        store.commit('read_diamondExchanger')

          setInterval(()=>{
            store.commit('read_diamond')
            store.commit('read_masterchef')
            store.commit('read_jackpot')
            store.commit('read_reward')
            store.commit('read_liquiditygenerator')
            store.commit('read_fantoonnft')
//          store.commit('read_diamondExchanger')
          },30000)
        }
      },
    render: h => h(App),
}).$mount('#app')