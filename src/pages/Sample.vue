<template>
  <div class="sample">
    <h1>Sample</h1>
    <div class="count">動物リスト：{{ animals.length }}匹</div>
    <br>
    <div class="loading" v-if="animals.length == 0">読み込み中...</div>
    <div class="animal" v-for="animal in animals">
      <div class="row">id : {{ animal.id }}</div>
      <div class="row">体重：{{ animal.weight }}kg</div>
      <div class="row">名前：{{ animal.name }}</div>
      <hr>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  components: {
  },
  mixins: [],
  computed: {
  },
  data() {
    return {
      animals: [],
    };
  },
  watch: {
  },
  created() {
  },
  mounted() {
    this.fetchAnimals();
  },
  methods: {
    async fetchAnimals() {
      const response = await axios.get('/api/sample');
      console.log(response);
      this.animals = response.data.animals;
    },
  },
}
</script>

<style scoped lang="scss">
.sample {
}
</style>
