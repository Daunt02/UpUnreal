/* eslint-env node */

import { configure } from 'quasar/wrappers'

export default configure(function (ctx) {
  return {
    supportTS: false,

    css: ['app.scss'],

    extras: [
      'material-icons' // optional: also available are mdi, fontawesome, etc.
    ],

    build: {
      vueRouterMode: 'history',
    },

    devServer: {
      port: 9000,
      open: true
    },

    framework: {
      plugins: ['Notify', 'Dialog', 'Loading'],
      config: {
        brand: {
          primary: '#1e1e1e',
          secondary: '#00bcd4',
          accent: '#9C27B0'
        }
      }
    },

    animations: [],
    ssr: false,
    pwa: false,
    cordova: false,
    capacitor: false,
    bex: false
  }
})
