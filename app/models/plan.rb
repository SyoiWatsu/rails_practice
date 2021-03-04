class Plan < ApplicationRecord
  belongs_to :user
  # '[user]' table to JOIN suru
  # tsukau key ha '[user]_id'
  has_many :visit_applications
  # [visit_application] to JOIN
  # [visit_application] no plan_id(primary_key) wo tsukau
  has_many :users, through: :visit_applications

  # 色々ヤッテくれちゃってる。
  # Primaryキー以外を指定したいときは指定するコードを書けばOK
end
