class VisitApplication < ApplicationRecord
  belongs_to :user, foreign_key: :applicant_id
  belongs_to :plan
end

# 関連づけたい先が"モデル名_id"なら、
# 特にどこに関連付けたいか指定しなくても
# railsが勝手に良い感じに察してやってくれる。
# (上記planのパターン)

# そうではないところに関連付けたいなら
# 自分で「関連づいて欲しいところはココだよ！」と教えてあげないといけない。
# (上記userのパターン)

