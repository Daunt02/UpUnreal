<template>
    <div id="map" class="w-full h-full"></div>
  </template>
  
  <script setup>
  import { onMounted, ref } from 'vue'
  import mapboxgl from 'mapbox-gl'
  import axios from 'axios'
  
  const mapContainer = ref(null)
  
  // Mapbox Access Token — Use .env for production
  mapboxgl.accessToken = 'YOUR_MAPBOX_TOKEN'
  
  onMounted(async () => {
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/dark-v10',
      center: [-95.3698, 29.7604], // Houston, TX
      zoom: 12,
      pitch: 45,
      bearing: -15,
      antialias: true
    })
  
    map.addControl(new mapboxgl.NavigationControl())
    map.addControl(new mapboxgl.FullscreenControl())
  
    try {
      const { data } = await axios.get('http://localhost:8000/api/sigils')
  
      data.forEach((sigil) => {
        const el = document.createElement('div')
        el.className = 'sigil-marker'
        el.style.width = '24px'
        el.style.height = '24px'
        el.style.borderRadius = '50%'
        el.style.backgroundColor = sigil.tier >= 3 ? '#ff66cc' : '#66ccff'
        el.style.border = '2px solid white'
  
        const popup = new mapboxgl.Popup({ offset: 25 }).setHTML(
          `<h3>${sigil.title}</h3>
           <p><strong>Tier:</strong> ${sigil.tier}</p>
           <p><strong>Trust:</strong> ${Math.round(sigil.trust * 100)}%</p>`
        )
  
        new mapboxgl.Marker(el)
          .setLngLat(sigil.coordinates)
          .setPopup(popup)
          .addTo(map)
      })
    } catch (err) {
      console.error('Failed to load sigil markers:', err)
    }
  })
  </script>
  
  <style>
  #map {
    height: 100vh;
    width: 100vw;
  }
  .sigil-marker {
    transition: transform 0.3s ease;
  }
  .sigil-marker:hover {
    transform: scale(1.3);
    cursor: pointer;
  }
  </style>
  