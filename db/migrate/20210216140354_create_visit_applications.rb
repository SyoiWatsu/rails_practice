class CreateVisitApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :visit_applications do |t|
      t.integer :visit_application_id
      t.integer :plan_id
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
