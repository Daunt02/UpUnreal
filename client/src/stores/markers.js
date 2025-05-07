import { defineStore } from 'pinia'

export const useMarkerStore = defineStore('markers', {
  state: () => ({
    sigils: [],
    selectedSigil: null
  }),
  actions: {
    setSigils(data) {
      this.sigils = data
    },
    selectSigil(sigil) {
      this.selectedSigil = sigil
    }
  }
})
