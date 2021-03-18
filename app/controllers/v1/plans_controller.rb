class V1::PlansController < ApplicationController

  before_action :authenticate_user!, only: [:create, :get_current_user]

  def get_current_user

    p current_user

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

    p "current_user : " + user_id.to_s

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

    plansData = Plan.all.group_by{|plan| plan.user_id}

    # planDataの有無で条件分岐
    if plansData
      obj = {
        msg: "success !!",
        plansData: plansData,
      }

      render(json: obj, status: 200)
    else
      render(json: {msg: "failed ..."}, status: 422)
    end

    # plansData = [
    #   {
    #     user_id: 1,
    #     user_name: "hoge"
    #     plans: [
    #       {
    #         plan_id: 1,
    #         title: "hoge1",
    #       },
    #       {
    #         plan_id: 2,
    #         title: "hoge2",
    #       },
    #     ]
    #   },
    #   {
    #     user_id: 2,
    #     user_name: "mage",
    #     plans: [
    #       {
    #         plan_id: 3,
    #         title: "mage1",
    #       },
    #       {
    #         plan_id: 4
    #         title: "mage4",
    #       },
    #     ]
    #   },
    # ]
    # 
    # ↑ こんな感じのデータを返したい

    # その為には
    # ① Plan全件取得
    # ② IDでグルーピング
    # ていう感じで受け取った後にこっちでデータ加工すればいいのかな？
    # それとも取得時点でここの処理をDB側に指示して願いすることできるのかな？
    # なんとなく後者な気がするけど、find_by_sql使えばいいのかなあ
    # → https://bit.ly/3rpLByK
    # 
    # DB側にグルーピング任せた時に返ってくる値ってどういう形で返ってくるんだろう。
    # そのへんも全然わからんな。ちょっと調べて分からなかったら
    # 全件取得からのこっちでグルーピングやっちゃうか
    # 　↓
    # group_by使うとこういう感じでハッシュで返ってくるらしい！イケる。
    # → https://bit.ly/3v3RjZ4

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
