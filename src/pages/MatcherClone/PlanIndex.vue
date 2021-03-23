<template>
  <div>
    <h1>PlanIndex</h1>
    <div class="search">
      <label for="Search">Search : </label>
      <input type="text" id="Search" v-model="keyword">
      <button v-on:click="showSearchResult">Go !</button>
    </div>
    <hr>
    <div>
      <div v-for="plans in groupedPlans">
        <p>▶︎ Plans made by user_id : {{ plans[0].user_id }}</p>
        <ul>
          <li v-for="(plan, index) in plans" v-on:click="showDetail(plan.id)">Plan_{{ index + 1 }} : {{ plan.title }}</li>
        </ul>
        --- --- --- --- --- --- ---
      </div>
    </div>
    <hr>

  </div>
</template>

<script>
import axios from "axios"; //axiosを使う準備

//他のファイルでimportされたときに戻り値
export default {
  components: {
  },
  mixins: [],
  computed: {
  },
  data() {
    return {
      groupedPlans: [], //APIから受け取ったPlanの配列データを格納しておく為の変数
      keyword : "",
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

    //検索結果画面を表示する関数
    showSearchResult() {

      if(this.keyword == ""){
        alert("No keyword entered ...");
        return;
      }

      const query = {
        search: this.keyword,
      };

      this.$router.push({name: "PlanSearchResult", query: query});
    },
    
    //Plan詳細を表示する関数 
    showDetail(planId) {
      this.$router.push({name: "PlanDetail", params: {id: planId}});
    },

    // Planのデータを取得する関数
    async fetchPlansData() {
      const endpoint = "/api/v1/plans";
      const response = await axios.get(endpoint);
      this.groupedPlans = response.data.groupedPlans;
    },
  },
}
</script>

<style scoped lang="scss">

</style>
