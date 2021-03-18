<template>
  <div>
    <h1>SignUp</h1>
    <div>
      <label for="Name">Name : </label>
      <input type="text" id="Name" v-model="name">
    </div>
    <div>
      <label for="Mail">Mail : </label>
      <input type="text" id="Mail" v-model="email">
    </div>
    <div>
      <label for="Password">Password : </label>
      <input type="text" id="Password" v-model="password">
    </div>
    <button v-on:click="signUp">Sign Up</button>
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
      name : "",
      email : "",
      password : "",
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
    async signUp() {
      
      //ユーザーの入力情報を受け取ってSignUp
      const endpoint = "http://localhost:5000/api/v1/auth";
      const body = {
        email : this.email,
        password : this.password,
        name : this.name
      };

      const vm = this;

      const response = await axios
        .post(endpoint, body)
        .catch(function(error){
          console.log(error);
        });

      localStorage.setItem("access-token", response.headers["access-token"]);
      localStorage.setItem("client", response.headers["client"]);
      localStorage.setItem("uid", response.headers["uid"]);

      alert("SignUp completed !!")
      this.name = "";
      this.email = "";
      this.password = "";

      this.$router.push({name : "PlanIndex"}) //PlanIndexに画面遷移
    },

    //現在ログイン中のユーザーを取得
    async fetchCurrentUser() {
      const endpoint = "/api/current-user";

      //localStorageに保存してある各種ログインデータを取得
      const accessToken = localStorage.getItem("access-token");
      const client = localStorage.getItem("client");
      const uid = localStorage.getItem("uid");

      //Postリクエスト時に渡すheaders
      const headers = {
        "Access-Token" : accessToken,
        "Client" : client,
        "Uid" : uid,
      };

      const response = await axios.get(endpoint, {
          headers : headers,
          data : {},
        });
      
      const currentUser = response.data.current_user;
      const msg = "You have already signed in [" + currentUser.uid + "] !!!" + "\n" + 
                  "If you want to sign in another account, " + "\n" + 
                  "don't forget to sign out from current account !!";
      alert(msg);

      this.$router.push({name : "SignOut"}); //SignOutに画面遷移
    },
  },
}
</script>

