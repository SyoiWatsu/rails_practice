class Plan < ApplicationRecordd
  belongs_to :user

  has_many :visit_applications
  has_many :users, through :visit_applications
end
