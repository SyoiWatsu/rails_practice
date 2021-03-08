<template>
  <div>
    <h1>PlanDetail</h1>
    Plan ID：<input type="number" v-model="plan_id">
    <button v-on:click="submit">Submit</button>
    <ul>
      <li>Title : {{ title }}</li>
      <li>Detail : {{ detail }}</li>
      <li>User ID : {{ user_id }}</li>
    </ul>
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
      title : "",
      detail : "",
      user_id : 0,
      plan_id : this.$route.params.id,
    };
  },
  watch: {
  },
  created() {
  },
  mounted() {
    this.fetchPlanDetail();
  },
  methods: {

    submit : function(){

      if(this.plan_id === 0 || this.plan_id === ""){
        alert("Plan ID が指定されていません！");
        return;
      }

      const baseUrl = "matcher-clone/plans/";
      this.$router.push(this.plan_id);
      // this.$router.push(baseUrl +  this.plan_id); 
      // ↑ なんでこっちじゃないんだろう？ (なぜかURLの前半部分が重なる)
      // PlanIndexの方ではコッチの書き方してるのに。


      this.fetchPlanDetail();
    },


    fetchPlanDetail : function(){

      //エンドポイントのURL
      const endpoint = "/api/v1/plans/" + this.plan_id;

      //localStorageに保存してある各種ログインデータを取得
      const access_token = localStorage.getItem("access-token");
      const client = localStorage.getItem("client");
      const uid = localStorage.getItem("uid");

      //Postリクエスト時に渡すheaders
      const headers = {
        "Access-Token" : access_token,
        "Client" : client,
        "Uid" : uid,
      };
      // ↑ 飛ばしてる先のshowアクションはbefore_actionで
      // ログインしてるかどうか見てないから無しでもイケる。
      // けど、一応残しておく。

      //自身のvueインスタンスを変数vmに格納しておく
      let vm = this;

      //Getリクエスト
      axios.get(endpoint, {
        headers : headers,
        data : {},
      })
      .then(function(response){ //処理成功
        console.log(response);
        const planData = response.data.plan;
        console.log(planData);

        vm.title = planData.title;
        vm.detail = planData.detail;
        vm.user_id = planData.user_id;

        const msg = "取得成功！" + "\n" + 
                    "title : " + vm.title + "\n" + 
                    "detail : " + vm.detail + "\n" + 
                    "user_id : " + vm.user_id;

        // alert(msg);
      })
      .catch(function(error){ //処理失敗
        console.log(error);

        alert("取得に失敗しました...");

        vm.title = "[No Data]";
        vm.detail = "[No Data]";
        vm.user_id = "[No Data]";
      });

    },
  },
}
</script>

