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
      
    },
  },
}
</script>

