<template>
  <div>
    <h1>PlanDetail</h1>
    User ID を指定：<input type="number" v-model="input_user_id">
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
      input_user_id : 0,
    };
  },
  watch: {
  },
  created() {
  },
  mounted() {
    // this.getPlanDetail();
  },
  methods: {

    submit : function(){

      if(this.input_user_id === 0 || this.input_user_id === ""){
        alert("User ID が指定されていません！");
        return;
      }

      this.getPlanDetail();
    },


    getPlanDetail : function(){

      //エンドポイントのURL
      const endpoint = "/api/v1/plans/" + this.input_user_id;

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
        const title = planData.title;
        const detail = planData.detail;
        const user_id = planData.user_id ? planData.user_id : "[No Data]";

        vm.title = title;
        vm.detail = detail;
        vm.user_id = user_id;

        const msg = "取得成功！" + "\n" + 
                    "title : " + title + "\n" + 
                    "detail : " + detail + "\n" + 
                    "user_id : " + user_id;

        alert(msg);

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

