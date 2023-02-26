class AddLunchPartners < ActiveRecord::Migration[6.1]
  def change
    create_table :lunch_partners do |t|
      t.timestamps
      t.string :month

      t.references :employee, null: false,  foreign_key: true
      t.references :lunch_group, null: false,  foreign_key: true

      t.index [:employee_id, :month],  unique: true, name: "idx_emp_month"
      t.index [:employee_id, :lunch_group_id],  unique: true, name: "idx_emp_group"
    end
  end
end