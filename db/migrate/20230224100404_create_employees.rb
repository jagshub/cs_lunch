class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :age
      t.string :sex

      t.timestamps
    end
  end
end
