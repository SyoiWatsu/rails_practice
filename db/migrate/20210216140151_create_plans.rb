class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.integer :plan_id
      t.integer :user_id
      t.string :title
      t.string :detail

      t.timestamps
    end
  end
end
