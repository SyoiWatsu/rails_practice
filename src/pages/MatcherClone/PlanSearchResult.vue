<template>
  <div>
    <h1>PlanSearchResult</h1>
    <div class="search">
      <label for="Search">Search : </label>
      <input type="text" id="Search" v-model="keyword">
      <button @click="showSearchResult">Go !</button>
    </div>
    <hr>
    <div>
      <div v-for="planData in plansData">
        <p>▶︎ Plans made by user_id : {{ planData[0].user_id }}</p>
        <ul>
          <li v-for="(plan, index) in planData" @click="showDetail(plan.id)">Plan_{{ index + 1 }} : {{ plan.title }}</li>
        </ul>
      </div>
    </div>
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
      plansData: [], //APIから受け取ったPlsnの配列データを格納しておく為の変数
      keyword : "",
    };
  },
  watch: {
  },
  created() {
  },
  mounted() {
    this.keyword = this.$route.query.search;
    this.fetchSearchResults();
  },
  methods: {

    //Plan検索結果を取得する関数
    async fetchSearchResults() {

      //エンドポイントのURL
      const endpoint = "/api/v1/plans/search";
      const params = {
        keyword : this.keyword,
        // ココまだ複数条件対応できていない
      };

      console.log("here");

      const responce = await axios.get(endpoint, {params : params});
      this.plansData = responce.data.search_result;
    },

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
      const params = {
        id: planId,
      };
      this.$router.push({name: "PlanDetail", params: params});
    },
  },

  beforeRouteUpdate (to, from, next) {
    this.fetchSearchResults(this.keyword); //データを再取得
    next();
  }
}
</script>

<style scoped lang="scss">

</style>
