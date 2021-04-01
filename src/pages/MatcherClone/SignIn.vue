<template>
  <div>
    <h1>SignIn</h1>
    <div>
      <label for="Mail">Mail : </label>
      <input type="text" id="Mail" v-model="email">
    </div>
    <div>
      <label for="Password">Password : </label>
      <input type="text" id="Password" v-model="password">
    </div>
    <button v-on:click="signIn">Sign In</button>
  </div>
</template>

<script>
import axios from "axios"; //axiosを使う準備
import {getUserAuthHeaders} from "../../js/utils";

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
    async signIn() {
      //ユーザーの入力情報を受け取ってSignIn
      const endpoint = "http://localhost:5000/api/v1/auth/sign_in";
      const body = {
        email : this.email,
        password : this.password,
      };

      const response = await axios.post(endpoint, body)
        .catch(function(error){
          console.log(error);
        });
      
      localStorage.setItem("access-token", response.headers["access-token"]);
      localStorage.setItem("client", response.headers["client"]);
      localStorage.setItem("uid", response.headers["uid"]);

      alert("SignIn completed !!")
      this.email = "";
      this.password = "";

      this.$router.push({name : "PlanIndex"}) //PlanIndexに画面遷移
    },

    //現在ログイン中のユーザーを取得
    async fetchCurrentUser() {

      //Postリクエスト時に渡すheaders
      const headers = getUserAuthHeaders();

      const response = await axios.get(GET_CURRENT_USER_URL, {
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

