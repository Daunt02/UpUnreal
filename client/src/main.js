import { createApp } from 'vue'
import { Quasar, Notify, Dialog, Loading } from 'quasar'
import App from './App.vue'
import router from './router'
import pinia from './stores'

// Quasar styles
import 'quasar/dist/quasar.css'
import '@quasar/extras/material-icons/material-icons.css'

// Global app styles
import './assets/global.css'

// Mapbox GL JS Styles (optional for scoped fallback)
import 'mapbox-gl/dist/mapbox-gl.css'

const app = createApp(App)

app.use(Quasar, {
  plugins: {
    Notify,
    Dialog,
    Loading
  },
  config: {
    brand: {
      primary: '#1e1e1e',
      secondary: '#00bcd4',
      accent: '#9C27B0'
    }
  }
})

app.use(pinia)
app.use(router)
app.mount('#q-app')
