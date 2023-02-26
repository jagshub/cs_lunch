class AddLunchGroup < ActiveRecord::Migration[6.1]
  def change
    create_table :lunch_groups do |t|
      t.string :name
      t.datetime :lunch_date

      t.timestamps
    end
  end
end
