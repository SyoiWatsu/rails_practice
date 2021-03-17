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
      <div v-for="planData in plansData">
        <p>▶︎ Plans made by user_id : {{ planData[0].user_id }}</p>
        <ul>
          <li v-for="(plan, index) in planData" v-on:click="showDetail(plan.id)">Plan_{{ index + 1 }} : {{ plan.title }}</li>
        </ul>
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
      plansData: [], //APIから受け取ったPlsnの配列データを格納しておく為の変数
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
    showSearchResult : function(){
      console.log("called showSearchResult !!");

      if(this.keyword == ""){
        alert("No keyword entered ...");
        return;
      }

      const baseUrl = "matcher-clone/plans/";
      const query = "?search=" + this.keyword;

      // ここでクエリつきのURLを渡してあげる
      this.$router.push(baseUrl + query);
    },
    
    //Plan詳細を表示する関数 
    showDetail : function(planId){
      const baseUrl = "matcher-clone/plans/";
      this.$router.push(baseUrl + planId);
    },

    // Planのデータを取得する関数
    async fetchPlansData() {
      const response = await axios.get("/api/v1/plans");
      this.plansData = response.data.plansData;
      // console.log(this.plansData);
      // console.log("length : " + Object.keys(this.plansData).length);
      // console.log("40 : " + this.plansData["40"][0].id);
    },
  },
}
</script>

<style scoped lang="scss">

</style>
