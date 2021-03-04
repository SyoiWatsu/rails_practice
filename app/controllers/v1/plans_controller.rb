class V1::PlansController < ApplicationController

  before_action :authenticate_user!, only: [:create]

  def create
    # ①Vueからjson受け取り
    json_request = JSON.parse(request.body.read) # ←paramsメソッド使うからコレいらんか

    # ②jsonパース
    title = params[:title]
    detail = params[:detail]
    user_id = current_user.id

    # ③受け取った値を元にPlanのインスタンス作成
    newPlan = Plan.new()
    newPlan.title = title
    newPlan.detail = detail
    newPlan.user_id = user_id

    # ④保存
    if newPlan.save
      
      obj = {
        msg: "success !!",
        newPlan: {
          title: title,
          detail: detail,
          uesr_id: user_id,
        },
      }

      render(json: obj, status: 200)
    else
      render({msg: "failed ..."}, status: 500)
    end
  end


  def show
    p params # paramsの中身確認してみる

    plan = Plan.find_by(id: params[:id]) # PlanをIDで検索

    # ↓できればココで対象となるレコードがあるかないかで条件分岐したい。
    # コレでできるかなと思ったけどできないマン
    if plan
      obj = {
        msg: "success !!",
        plan: {
          title: plan.title,
          detail: plan.detail,
          uesr_id: plan.user_id,
        },
      }

      render(json: obj, status: 200)
    else
      render(json: {msg: "failed ..."}, status: 422)
    end
  end

end
