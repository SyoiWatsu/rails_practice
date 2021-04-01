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
import {getUserAuthHeaders, fetchCurrentUser} from "../../js/utils";

const PLANS_NEW_URL = "/api/v1/plans/new";
const GET_CURRENT_USER_URL = "/api/current-user";

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
      accessToken : "",
      client : "",
      uid : "",
    };
  },
  watch: {
  },
  created() {
  },
  mounted() {
    this.init();
  },
  methods: {
    async createNewPlan() {

      if(this.title === "" || this.detail === ""){
        alert("There is a blank field.");
        return;
      }

      //Postリクエスト時に渡すbody
      const body = {
        title : this.title,
        detail : this.detail,
      }

      //Postリクエスト時に渡すheaders
      const headers = {
        "Access-Token" : this.access_token,
        "Client" : this.client,
        "Uid" : this.uid,
      };

      //自身のvueインスタンスを変数vmに格納しておく
      let vm = this;

      //Postリクエスト
      await axios.post(PLANS_NEW_URL, body, {
        headers : headers
      })
      .catch(function(error){ //処理失敗
        console.log(error);

        alert("保存に失敗しました...");
      });

      //メッセージ表示
      const msg = "保存に成功しました！" + "\n" + 
                  "title : " + vm.title + "\n" + 
                  "detail : " + vm.detail;
      alert(msg);

      //PlanIndexに画面遷移
      vm.$router.push({name : "PlanIndex"});
    },

    //現在ログイン中のユーザーを取得
    async init() {

      //Postリクエスト時に渡すheaders
      const headers = getUserAuthHeaders();

      // 取得した値を使い回す為にプロパティに
      this.accessToken = headers.accessToken;
      this.uid = headers.uid;
      this.client = headers.client;

      const currentUser = await fetchCurrentUser();

      this.currentUser.id = currentUser.id;
      this.currentUser.uid = currentUser.uid;
      this.currentUser.name = currentUser.name;
    },
  },
}
</script>

