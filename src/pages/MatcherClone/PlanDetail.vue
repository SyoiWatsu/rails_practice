<template>
  <div>
    <h1>PlanDetail</h1>
    Plan ID : <input type="number" v-model="planId">
    <button v-on:click="submit">Submit</button>
    <ul>
      <li>Title : {{ title }}</li>
      <li>Detail : {{ detail }}</li>
      <li>User ID : {{ userId }}</li>
    </ul>
    <button v-on:click="apply">Apply</button>
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
      title: "",
      detail: "",
      userId: 0,
      planId: this.$route.params.id,
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

    submit() {

      if(this.planId === 0 || this.planId === ""){
        alert("Plan ID が指定されていません！");
        return;
      }

      const params ={
        id: this.planId
      };
      this.$router.push({name: "PlanDetail", params: params});
      
      this.fetchPlanDetail();
    },

    async fetchPlanDetail() {

      //エンドポイントのURL
      const endpoint = "/api/v1/plans/" + this.planId;

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

      const response = await axios.get(endpoint, {
        headers : headers,
        data : {},
      })
      .catch(function(error){
        console.log(error);
        alert("取得に失敗しました...");

        vm.title = "[No Data]";
        vm.detail = "[No Data]";
        vm.userId = "[No Data]";
      });

      const plan = response.data.plan;
      this.title = plan.title;
      this.detail = plan.detail;
      this.userId = plan.userId;
    },

    apply() {
      const msg = "Apply this plan ?" + "\n" + 
                  "--- --- --- --- ---" + "\n" + 
                  "title : " + this.title + "\n" + 
                  "detail : " + this.detail + "\n" + 
                  "userId : " + this.userId + "\n" + 
                  "--- --- --- --- ---" 
                  ;
      const result = confirm(msg);
      if(result == false){ return }

      // ここにApplyの処理を書いていく。
      // プランへの申し込みができている状態とは
      // 『visit_applicationテーブルにレコードが格納できた状態』を指す。
      // → visit_applicationテーブルに対してレコードブチ込む処理をここですればOK？
    }
  },
}
</script>

