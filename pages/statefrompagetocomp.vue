<template>
  <div>
    <statefrompagetocomp v-model="email" />
    <h1>Your Email: {{ email }}</h1>
    <h1>Your Password: {{ password }}</h1>
    <h1>Yoaur Notes: {{ notes }}</h1>
  </div>
</template>

<script>
import statefrompagetocomp from '@/components/statefrompagetocomp'

export default {
  components: {
    statefrompagetocomp
  },
  data() {
    return {
      email: '',
      password: '',
      notes: ''
    }
  },
  methods: {
    onSubmitBor() {
      this.$router.push('/')
    },
    changeValue(value) {
      console.log(value)
    }
  }
}
</script>
