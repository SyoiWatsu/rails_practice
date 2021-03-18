<template>
  <div>
    <h1>NewPlan</h1>
    <p>Current User</p>
    <ul>
      <li>ID : {{ currentUser.id }}</li>
      <li>Uid : {{ currentUser.uid }}</li>
      <li>Name : {{ currentUser.name }}</li>
    </ul>
    <hr>
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
      currentUser : {
        id : 0,
        uid : "",
        name : "",
      },
    };
  },
  watch: {
  },
  created() {
  },
  mounted() {
    this.fetchCurrentUser();
  },
  methods: {
    createNewPlan : function(){

      if(this.title === "" || this.detail === ""){
        alert("未入力欄あり");
        return;
      }

      //エンドポイントのURL
      const endpoint = "/api/v1/plans/new";

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

    //現在ログイン中のユーザーを取得
    fetchCurrentUser : async function(){
      const endpoint = "/api/current-user";

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

      //Getリクエスト
      const response = await axios.get(endpoint, {
        headers : headers,
        data : {},
      });

      console.log(response);
      const currentUser = response.data.current_user;
      this.currentUser.id = currentUser.id;
      this.currentUser.uid = currentUser.uid;
      this.currentUser.name = currentUser.name;

    },
  },
}
</script>

