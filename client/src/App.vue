<template>
  <q-layout view="hHh lpR fFf">
    <q-header elevated class="bg-primary text-white">
      <q-toolbar>
        <q-toolbar-title>
          SigilOS
        </q-toolbar-title>
        <q-btn flat round icon="person" @click="showProfile" />
      </q-toolbar>
    </q-header>

    <q-page-container>
      <router-view />
    </q-page-container>
  </q-layout>
</template>

<script setup>
import { useQuasar } from 'quasar'

const $q = useQuasar()

function showProfile () {
  $q.dialog({
    title: 'User',
    message: 'Profile options coming soon.'
  })
}
</script>

<style scoped>
body {
  font-family: 'Inter', sans-serif;
}
</style>
