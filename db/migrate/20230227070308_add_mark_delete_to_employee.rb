class AddMarkDeleteToEmployee < ActiveRecord::Migration[6.1]
    def up
      add_column :employees, :to_delete, :boolean, default: false
    end

    def down
      add_column :employees, :to_delete
    end
end
