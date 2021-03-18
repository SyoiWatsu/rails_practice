class V1::PlansController < ApplicationController

  before_action :authenticate_user!, only: [:create, :get_current_user]

  def get_current_user
    obj = {
      current_user: current_user,
    }
    render(json: obj, status: 200)
  end

  def create
    # ①Vueからjson受け取り
    json_request = JSON.parse(request.body.read) # ←paramsメソッド使うからコレいらんか

    # ②jsonパース
    title = params[:title]
    detail = params[:detail]
    user_id = current_user.id

    # ③受け取った値を元にPlanのインスタンス作成
    new_plan = Plan.new()
    new_plan.title = title
    new_plan.detail = detail
    new_plan.user_id = user_id

    # ④保存
    if new_plan.save
      
      obj = {
        msg: "success !!",
        new_plan: {
          title: title,
          detail: detail,
          user_id: user_id,
        },
      }

      render(json: obj, status: 200)
    else
      render({msg: "failed ..."}, status: 500)
    end
  end

  def index

    grouped_plans = Plan.all.group_by{|plan| plan.user_id}

    # planDataの有無で条件分岐
    if grouped_plans
      obj = {
        msg: "success !!",
        groupedPlans: grouped_plans,
      }

      render(json: obj, status: 200)
    else
      render(json: {msg: "failed ..."}, status: 422)
    end
  end

  def search
    
    # ここでVueからパラメータ受け取って、それをkeywordに入れる
    p params

    keyword = params[:keyword]
    search_result =  Plan
                       .where("title like ?","%#{keyword}%")
                       .group_by{|plan| plan.user_id}
    # ココまだ複数条件対応できていない。
    # 配列とかで値もらってこっちでパースしてひとつひとつブチ込む、
    # みたいな形になるかな？
 
    # 最終的にはココ参考に → https://bit.ly/3bAZHYC
    # 現状のMatcherのURLもこんな感じになってる。
    
    if search_result
      obj = {
        msg: "success !!",
        search_result: search_result,
      }

      render(json: obj, status: 200)
    else
      render(json: {msg: "failed ..."}, status: 422)
    end
  end

  def show
    p params # paramsの中身確認してみる

    plan = Plan.find_by(id: params[:id]) # PlanをIDで検索

    # planの有無で条件分岐
    if plan
      obj = {
        msg: "success !!",
        plan: {
          title: plan.title,
          detail: plan.detail,
          user_id: plan.user_id,
        },
      }

      render(json: obj, status: 200)
    else
      render(json: {msg: "failed ..."}, status: 422)
    end
  end

end
