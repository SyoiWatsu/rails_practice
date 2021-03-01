<template>
  <div>
    <h1>SignUp</h1>
    <div>
      <label for="Name">Name : </label>
      <input type="text" id="Name" v-model="name">
    </div>
    <div>
      <label for="Mail">Mail : </label>
      <input type="text" id="Mail" v-model="mail">
    </div>
    <div>
      <label for="Password">Password : </label>
      <input type="text" id="Password" v-model="password">
    </div>
    <button v-on:click="signIn">Sign Up</button>
  </div>
</template>

<script>
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
      mail : "",
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
    signIn : function(){
      console.log('SignInボタンが押された！');
    }
  },
}
</script>

