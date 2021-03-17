<template>
  <div>
    <h1>PlanSearchResult</h1>
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
    <div class="memo">
      <開発memo> <br>
      『Index → Detail』への画面遷移はできる <br>
      『SearchResult → Detail』への画面遷移ができない。<br>
      なんで？
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
    this.fetchSearchResults(this.keyword);
  },
  methods: {

    //Plan検索結果を取得する関数
    fetchSearchResults : async function(keyword){
      console.log("called fetchSearchResults");

      //エンドポイントのURL
      const endpoint = "/api/v1/plans/search";
      const params = {
        keyword : keyword,
        // ココまだ複数条件対応できていない
      };

      const responce = await axios.get(endpoint, {params : params});
      const searchResult = responce.data.search_result;
      console.log(searchResult);
      this.plansData = searchResult;

      // ココ見つつやる → https://github.com/axios/axios#example
      // 理想はfetchPlanDetailでやってるみたいに
      // ① VueRouterで画面遷移
      // ② 遷移先のmountedでRailsAPI呼び出し
      // みたいな形が良いのかな...？
      // と、いうことは検索結果表示用の画面をIndexとは別で作らねば....？
    },

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
      // this.$router.push(baseUrl + query);
      this.$router.push(query);
    },
    
    //Plan詳細を表示する関数 
    showDetail : function(planId){
      const baseUrl = "matcher-clone/plans/";

      console.log("planId : " + planId); //クリックしたPlanのIDは取得できてる

      //これだと [/matcher-clone/plans/matcher-clone/plans/18] こうなる
      // this.$router.push(baseUrl + planId); 
      
      // これだと [/matcher-clone/plans/] こうなる (Viewも再描画されない)
      this.$router.push(planId);
    },

  },

  beforeRouteUpdate (to, from, next) {
    console.log("called beforeRouterUpdate !!!!");
    this.fetchSearchResults(this.keyword); //データを再取得
    next();
  }
}
</script>

<style scoped lang="scss">

</style>
