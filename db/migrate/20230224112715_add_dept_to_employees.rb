class AddDeptToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_reference :employees, :department
  end
end
