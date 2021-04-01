<template>
  <div>
    <h1>PlanDetail</h1>
    Plan ID : <input type="number" v-model="plan.id">
    <button v-on:click="submit">Submit</button>
    <ul>
      <li>Title : {{ plan.title }}</li>
      <li>Detail : {{ plan.detail }}</li>
      <li>User ID : {{ plan.userId }}</li>
    </ul>
    <button v-on:click="apply">Apply</button>
  </div>
</template>

<script>
import axios from "axios"; //axiosを使う準備
import {getUserAuthHeaders} from "../../js/utils";

const VISIT_APPLICATION_NEW_URL = "/api/v1/visit-application/new";
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
      plan: {
        id: this.$route.params.id,
        title: "",
        detail: "",
        userId: 0, //プラン作成者のuser_id
      },
      currentUserId: 0, //現在ログイン中のuser_id

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
    this.fetchPlanDetail();
    this.fetchCurrentUser();
  },
  methods: {

    submit() {

      if(this.plan.id === 0 || this.plan.id === ""){
        alert("Plan ID が指定されていません！");
        return;
      }

      const params ={
        id: this.plan.id,
      };
      this.$router.push({name: "PlanDetail", params: params});
      
      this.fetchPlanDetail();
    },

    async fetchPlanDetail() {

      //エンドポイントのURL
      const endpoint = "/api/v1/plans/" + this.plan.id;


      //Postリクエスト時に渡すheaders
      const headers = getUserAuthHeaders();
     
      //自身のvueインスタンスを変数vmに格納しておく
      let vm = this;

      const response = await axios.get(endpoint, {
        headers : headers,
        data : {},
      })
      .catch(function(error){
        console.log(error);
        alert("取得に失敗しました...");

        vm.plan.title = "[No Data]";
        vm.plan.detail = "[No Data]";
        vm.plan.userId = "[No Data]";
      });

      const plan = response.data.plan;
      this.plan.title = plan.title;
      this.plan.detail = plan.detail;
      this.plan.userId = plan.user_id;
    },

    async apply() {
      const msg = "Apply this plan ?" + "\n" + 
                  "--- --- --- --- ---" + "\n" + 
                  "title : " + this.plan.title + "\n" + 
                  "detail : " + this.plan.detail + "\n" + 
                  "userId : " + this.plan.userId + "\n" + 
                  "--- --- --- --- ---" 
                  ;
      const result = confirm(msg);
      if(result == false){ return }


      //Postリクエスト時に渡すbody
      const body = {
        authorizer_id: this.plan.userId, //被申込者のuser_id
        plan_id: this.plan.id, //申し込んだPlanのid
        status: "waiting",
      };

      //Postリクエスト時に渡すheaders
      const headers = getUserAuthHeaders();

      const response = await axios.post(VISIT_APPLICATION_NEW_URL, body, {
        headers : headers,
      })
      .catch(function(error){
        console.log(error);
        alert("申し込みに失敗しました...");
      });

      if(response.status == 204){
        const msg = "you have already applied, " + "\n" +
                    "so you cannot apply this plan.";
        alert(msg);
      }
    },

    //現在ログイン中のユーザーを取得
    fetchCurrentUser : async function(){
      
      //Postリクエスト時に渡すheaders
      const headers = getUserAuthHeaders();

      //Getリクエスト
      const response = await axios.get(GET_CURRENT_USER_URL, {
        headers : headers,
        data : {},
      });

      this.currentUserId = response.data.current_user.id;
    },
  },
}
</script>

