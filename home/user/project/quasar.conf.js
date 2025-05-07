/* eslint-env node */
const { configure } = require('quasar/wrappers')

module.exports = configure(function (ctx) {
  return {
    css: ['app.scss'],
    boot: [],
    build: {
      vueRouterMode: 'history',
    },
    devServer: {
      port: 9000,
      open: true
    },
    framework: {
      config: {},
      plugins: ['Notify']
    },
    animations: [],
    ssr: false,
    pwa: false
  }
})
