<template>
    <div id="map" ref="mapContainer" style="height: 100vh; width: 100vw;"></div>
  </template>
  
  <script setup>
  import { onMounted, ref } from 'vue'
  import mapboxgl from 'mapbox-gl'
  import { useMarkerStore } from '../stores/markers'
  import axios from 'axios'
  
  const mapContainer = ref(null)
  const store = useMarkerStore()
  let map = null
  
  mapboxgl.accessToken = 'pk.eyJ1IjoiZGF1bnQwMiIsImEiOiJjbWFkdjFuazYwMHZlMmpxMmlicWhic2IxIn0.N3sKKgZjX_lfHsS_vYoqxg' // ← replace with actual token
  
  function loadSigils(sigils) {
    sigils.forEach(sigil => {
      const el = document.createElement('div')
      el.className = 'sigil-marker'
      el.style.backgroundColor = getSigilColor(sigil.tier)
      el.style.width = '20px'
      el.style.height = '20px'
      el.style.borderRadius = '50%'
      el.style.cursor = 'pointer'
      el.style.border = '2px solid white'
      el.style.boxShadow = `0 0 ${sigil.trust * 20}px rgba(255,255,255,0.6)`
  
      const marker = new mapboxgl.Marker(el)
        .setLngLat(sigil.coordinates)
        .setPopup(
          new mapboxgl.Popup({ offset: 25 })
            .setHTML(`<h4>${sigil.title}</h4><p>Tier: ${sigil.tier}<br/>Trust: ${sigil.trust}</p>`)
        )
        .addTo(map)
  
      el.addEventListener('click', () => {
        store.selectSigil(sigil)
      })
    })
  }
  
  function getSigilColor(tier) {
    const colors = ['#999999', '#00BCD4', '#FFC107', '#FF5722', '#8BC34A', '#673AB7']
    return colors[tier % colors.length]
  }
  
  onMounted(async () => {
    map = new mapboxgl.Map({
      container: mapContainer.value,
      style: 'mapbox://styles/mapbox/dark-v10',
      center: [-95.3698, 29.7604], // Houston
      zoom: 11,
      pitch: 50,
      bearing: -15,
      antialias: true
    })
  
    try {
      const response = await axios.get('http://localhost:8000/api/sigils')
      store.setSigils(response.data)
      loadSigils(response.data)
    } catch (err) {
      console.error('Error loading sigils:', err)
    }
  })
  </script>
  
  <style scoped>
  .sigil-marker {
    transition: all 0.3s ease;
  }
  </style>
  