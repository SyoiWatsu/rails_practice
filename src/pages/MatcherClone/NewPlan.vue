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

      if(this.title === "" || this.detail === 0){
        alert("未入力欄あり");
        return;
      }

      let vm = this;
      const endpoint = "/api/v1/new";
      axios.post(endpoint, {
        title : vm.title,
        detail : vm.detail,
      })
      .then(function(response){ //処理成功
        console.log(response);

        const msg = "保存に成功しました！" + '\n' + 
                    "title : " + vm.title + '\n' + 
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

