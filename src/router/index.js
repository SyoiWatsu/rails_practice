import Vue from 'vue';
import VueRouter from 'vue-router';

//[src/pages]の中にVueファイルを作っていく
import Home from 'pages/Home';
import Sample from 'pages/Sample';
import New from 'pages/New';
import Index from 'pages/Index';

import SignUp from 'pages/MatcherClone/SignUp';
import SignIn from 'pages/MatcherClone/SignIn';
import SignOut from 'pages/MatcherClone/SignOut';
import PlanIndex from 'pages/MatcherClone/PlanIndex';
import PlanSearchResult from 'pages/MatcherClone/PlanSearchResult';
import NewPlan from 'pages/MatcherClone/NewPlan';
import PlanDetail from 'pages/MatcherClone/PlanDetail';


//ルーティング先になり得るとこををブチ込んでおく
const routes = [
  { path: '/', name: 'Home', component: Home },
  { path: '/sample', name: 'Sample', component: Sample },
  { path: '/new', name: 'New', component: New },
  { path: '/index', name: 'Index', component: Index },

  { path: '/matcher-clone/signup', name: 'SignUp', component: SignUp },
  { path: '/matcher-clone/signin', name: 'SignIn', component: SignIn },
  { path: '/matcher-clone/signout', name: 'SignOut', component: SignOut },
  { path: '/matcher-clone', name: 'PlanIndex', component: PlanIndex },
  { path: '/matcher-clone/plans', name: 'PlanSearchResult', component: PlanSearchResult },
  { path: '/matcher-clone/new-plan', name: 'NewPlan', component: NewPlan },
  { path: '/matcher-clone/plans/:id', name: 'PlanDetail', component: PlanDetail, props : true },
]

//VueRouterの使い方調べる必要あり
const router = new VueRouter({
  base: '/',
  routes,
})

export default router;
