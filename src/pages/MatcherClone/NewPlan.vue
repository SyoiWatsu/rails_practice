<template>
  <div>
    <h1>NewPlan</h1>
    <div>
      <label for="Title">PlanTitle : </label>
      <input type="text" id="Title" v-model="title">
    </div>
    <div>
      <label for="Detail">PlanDetail : </label>
      <input type="text" id="Detail" v-model="detail">
    </div>
    <button v-on:click="createNewPlan">Create New Plan</button>
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
    };
  },
  watch: {
  },
  created() {
  },
  mounted() {
  },
  methods: {
    createNewPlan : function(){

      if(this.title === "" || this.detail === ""){
        alert("未入力欄あり");
        return;
      }

      //エンドポイントのURL
      const endpoint = "/api/v1/new";

      //Postリクエスト時に渡すbody
      const body = {
        title : this.title,
        detail : this.detail,
      }

      //localStorageに保存してある各種ログインデータを取得
      const access_token = localStorage.getItem("access-token");
      const client = localStorage.getItem("client");
      const uid = localStorage.getItem("uid");
      console.log("access_token : " + access_token);

      //Postリクエスト時に渡すheaders
      const headers = {
        "Access-Token" : access_token,
        "Client" : client,
        "Uid" : uid,
      };
      // ↑コレでイケた！！！
      // が、なぜこれでイケたのかは良く分からない...
      // なんでリクエストヘッダーにこれを渡せばイケる？
      // 公式ドキュメントにも「こう書いてね」みたいの特に無かったし...(見つけることできてないだけ？)
      // あとで良く見てみる (→https://devise-token-auth.gitbook.io/devise-token-auth/)

      //自身のvueインスタンスを変数vmに格納しておく
      let vm = this;

      //Postリクエスト
      axios.post(endpoint, body, {
        headers : headers
      })
      .then(function(response){ //処理成功
        console.log(response);

        const msg = "保存に成功しました！" + "\n" + 
                    "title : " + vm.title + "\n" + 
                    "detail : " + vm.detail;
        alert(msg);

        vm.$router.push({name : "PlanIndex"}); //PlanIndexに画面遷移
      })
      .catch(function(error){ //処理失敗
        console.log(error);

        alert("保存に失敗しました...");
      });

    },
  },
}
</script>

