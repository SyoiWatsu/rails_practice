<template>
  <div>
    <h1>PlanIndex</h1>
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
      ① バックエンドで特定のキーワードを含む(もしくは完全一致？)のレコードを持ってくる <br>
      ② Vueからユーザーの入力をRailsに渡す <br>
      ③ ↑で受け取った値を使ってレコード持ってこれるようにする <br>
      ④ Vueで受け取って表示する
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
