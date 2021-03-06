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
      plans: [], //APIから受け取ったPlsnの配列データを格納しておく為の変数
    };
  },
  watch: {
  },
  created() {
  },
  mounted() {
    // this.fetchPlans();
  },
  methods: {
    async fetchPlans() {
      const response = await axios.get('/api/index');
      console.log(response);
      this.plans = response.data.plans;

      console.log(this.plans);
    },
  },
}
</script>

<style scoped lang="scss">

</style>
