<template>
  <div>
    <h1>SignOut</h1>
    <p>Current User</p>
    <ul>
      <li>ID : {{ currentUser.id }}</li>
      <li>Uid : {{ currentUser.uid }}</li>
      <li>Name : {{ currentUser.name }}</li>
    </ul>
    <button v-on:click="signOut">Sign Out</button>
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
      currentUser : {
        id : 0,
        uid : "",
        name : "",
      },
      access_token : "",
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
  },
  methods: {
    signOut : function(){
      console.log("SignOutボタンが押された！");
      const result = confirm("SignOut from [" + this.uid + "] .\n\nOK?");
      if(result != true){ return }
      
      //現在ログイン中のユーザーからSignOut
      const endpoint = "http://localhost:5000/api/v1/auth/sign_out";
      //リクエスト時に渡すheaders
      const headers = {
        "Access-Token" : this.access_token,
        "Client" : this.client,
        "Uid" : this.uid,
      };

      const vm = this; //自身のVueインスタンスを変数vmに格納
      axios
        .delete(endpoint, {
          headers : headers,
        })
        .then(function(response){
          console.log(response);

          localStorage.removeItem("access-token");
          localStorage.removeItem("client");
          localStorage.removeItem("uid");
          
          alert("SignOut from [" + vm.uid + "] completed !!");

          vm.$router.push({name : "SignIn"}); //SignInに画面遷移
        })
        .catch(function(error){
          console.log(error);
        });
    },

    //現在ログイン中のユーザーを取得
    fetchCurrentUser : async function(){
      const endpoint = "/api/current-user";

      //localStorageに保存してある各種ログインデータを取得
      this.access_token = localStorage.getItem("access-token");
      this.client = localStorage.getItem("client");
      this.uid = localStorage.getItem("uid");
      console.log("access_token : " + this.access_token);

      //Postリクエスト時に渡すheaders
      const headers = {
        "Access-Token" : this.access_token,
        "Client" : this.client,
        "Uid" : this.uid,
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

