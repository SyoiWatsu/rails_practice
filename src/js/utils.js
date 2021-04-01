import axios from "axios"; //axiosを使う準備

const GET_CURRENT_USER_URL = "/api/current-user";

export function getUserAuthHeaders() {

  const accessToken = localStorage.getItem("access-token");
  const client = localStorage.getItem("client");
  const uid = localStorage.getItem("uid");

  const obj = {
    "Access-Token" : accessToken,
    "Client" : client,
    "Uid" : uid,
  };

  return obj;
}

export async function fetchCurrentUser() {
  //Postリクエスト時に渡すheaders
  const headers = getUserAuthHeaders();

  //Getリクエスト
  const response = await axios.get(GET_CURRENT_USER_URL, {
    headers : headers,
    data : {},
  });

  const currentUser = response.data.current_user;

  const obj = {
    id: currentUser.id,
    uid: currentUser.uid,
    name: currentUser.name,
  };

  return obj;
}
// ↑コイツ作ったは良いけどあんま使い道なかったな...