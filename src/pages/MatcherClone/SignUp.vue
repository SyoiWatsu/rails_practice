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
  },
  methods: {
    signUp : function(){
      console.log("SignUpボタンが押された！");
      console.log("email : " + this.email);
      console.log("password : " + this.password);
      
      //ユーザーの入力情報を受け取ってSignUp
      const endpoint = "http://localhost:5000/api/v1/auth";
      const body = {
        email : this.email,
        password : this.password,
        name : this.name
      };

      const app = this;
      axios
        .post(endpoint, body)
        .then(function(response){
          console.log(response);

          //何のためにlocalStorageに保存するんだろう...？あまりその意味を分かっていない。 (参照；https://bit.ly/37XB8md)
          //その後の処理に都度使うから？
          localStorage.setItem("access-token", response.headers["access-token"]);
          localStorage.setItem("client", response.headers["client"]);
          localStorage.setItem("uid", response.headers["uid"]);

          alert("SignUp completed !!")
          app.name = "";
          app.email = "";
          app.password = "";

          //ここにIndexへのリダイレクト処理入れたい

        })
        .catch(function(error){
          console.log(error);
        });
    },
  },
}
</script>

