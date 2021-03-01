import Vue from 'vue';
import VueRouter from 'vue-router';

//[src/pages]の中にVueファイルを作っていく
import Home from 'pages/Home';
import Sample from 'pages/Sample';
import New from 'pages/New';
import Index from 'pages/Index';

import SignUp from 'pages/MatcherClone/SignUp'
import SignIn from 'pages/MatcherClone/SignIn'

//ルーティング先になり得るとこををブチ込んでおく
const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/sample', name: 'Sample', component: Sample },
  { path: '/new', name: 'New', component: New },
  { path: '/index', name: 'Index', component: Index },

  { path: '/matcher-clone/signup', name: 'SignUp', component: SignUp },
  { path: '/matcher-clone/signin', name: 'SignIn', component: SignIn },
]

//VueRouterの使い方調べる必要あり
const router = new VueRouter({
  base: '/',
  routes,
})

export default router;
