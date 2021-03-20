<template>
  <div>
    <h1>Notification</h1>
    <p>Current User</p>
    <ul>
      <li>ID : {{ currentUser.id }}</li>
      <li>Uid : {{ currentUser.uid }}</li>
      <li>Name : {{ currentUser.name }}</li>
    </ul>
    <hr>
    <div class="notifications">
      <div v-if="notifications.length == 0">[No notifications ...]</div>
      <div class="notification" v-for="(notification, index) in notifications">
        <div class="index">【{{ index }}】</div>
        <div class="applicant-name">Applicant Name : {{ notification.applicant.name }}</div>
        <div class="plan-title">Plan title : {{ notification.plan.title }}</div>
        --- --- --- --- --- --- ---
      </div>
    </div>
    <hr>
    <div class="memo">
      <開発memo> <br>
      ・自分が申請を出したプランが承認されたとき <br>
      ・自分のプランに申請が出されたとき <br>
      に通知が来るイメージ。<br>
      <br>
      PlanIDで表示することはできた。<br>
      でも理想は<br>
      『[UserName] さんから [PlanTitle] に対して申請が来ました』<br>
      だから、うまいことデータひっぱって来ないといけないけど、<br>
      いまいちRDBの良い使い方が分からない。<br>
      個別にuser_idとplan_id使ってデータ持ってくるのはなんかダサい気がする。<br>
      もっと良いやり方ありそう。<br>
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
      notifications: [],
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
    this.fetchCurrentUser();
    this.getNotifications();
  },
  methods: {

    //現在ログイン中のユーザーを取得
    async fetchCurrentUser() {
      const endpoint = "/api/current-user";

      //localStorageに保存してある各種ログインデータを取得
      this.accessToken = localStorage.getItem("access-token");
      this.client = localStorage.getItem("client");
      this.uid = localStorage.getItem("uid");

      //Postリクエスト時に渡すheaders
      const headers = {
        "Access-Token" : this.accessToken,
        "Client" : this.client,
        "Uid" : this.uid,
      };

      const vm = this; //自身のVueインスタンスを変数vmに格納

      const response = await axios
        .get(endpoint, {
          headers : headers,
          data : {},
        })
        .catch(function(error){
          console.log(error);
          alert("You are not signed in !!");
          vm.$router.push({name : "SignIn"}); //SignInに画面遷移
        });

      const currentUser = response.data.current_user;
      this.currentUser.id = currentUser.id;
      this.currentUser.uid = currentUser.uid;
      this.currentUser.name = currentUser.name;
    },

    async getNotifications() {
      const endpoint = "api/v1/notifications";

      //Getリクエスト時に渡すheaders
      const headers = {
        "Access-Token" : this.accessToken,
        "Client" : this.client,
        "Uid" : this.uid,
      };

      const response = await axios
        .get(endpoint, {
          headers : headers,
          data : {},
        })
        .catch(function(error){
          console.log(error);
          alert("faild to get notification ...");
        });

      console.log(response.data.notificatoins);
      this.notifications = response.data.notificatoins;
    }

    
  },
}
</script>

