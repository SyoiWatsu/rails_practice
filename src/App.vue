<template lang="pug">
  #app.App
    .header
      .header_item
        span Sample : 
        router-link.link(:to="{ name: 'Home' }") Home
        span / 
        router-link.link(:to="{ name: 'Sample' }") Sample
        span / 
        router-link.link(:to="{ name : 'New' }") New
        span / 
        router-link.link(:to="{ name : 'Index' }") Index
      .header_item
        span MatcherClone : 
        router-link.link(:to="{ name: 'SignUp' }") SignUp
        span / 
        router-link.link(:to="{ name: 'SignIn' }") SignIn
        span / 
        router-link.link(:to="{ name: 'PlanIndex' }") Index
        span / 
        router-link.link(:to="{ name: 'NewPlan' }") NewPlan
        span / 
    .main
      router-view
</template>

<script>

export default {
  components: {
  },
  computed: {
  },
  mounted() {
  },
  methods: {
  }
}
</script>

<style lang="scss">
</style>

<style scoped lang="scss">
.App {
  & {
  }
  .main {
  }
}
</style>
