class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.timestamps

      t.index [:name],  unique: true
    end
  end
end
