<template>
  <div>
    <h1>PlanIndex</h1>
    <p>comming soon ...</p>
  </div>
</template>

<script>
import axios from 'axios'; //axiosを使う準備

//他のファイルでimportされたときに戻り値
export default {
  components: {
  },
  mixins: [],
  computed: {
  },
  data() {
    return {
      plansData: [], //APIから受け取ったPlsnの配列データを格納しておく為の変数
    };
  },
  watch: {
  },
  created() {
  },
  mounted() {
    this.fetchPlansData();
  },
  methods: {
    async fetchPlansData() {
      const response = await axios.get('/api/v1/plans');
      this.plansData = response.data.plansData;
      console.log(this.plansData);
      console.log("length : " + Object.keys(this.plansData).length);
      console.log("40 : " + this.plansData["40"][0].id);

      // memo
      // オブジェクトのv-for　→ https://bit.ly/2Oxfm1O
      
    },
  },
}
</script>

<style scoped lang="scss">

</style>
