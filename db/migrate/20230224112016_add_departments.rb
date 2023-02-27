class AddDepartments < ActiveRecord::Migration[6.1]
  def up
    departments = ['Marketing', 'Sales', 'Support', 'Operations', 'HR', 'Legal', 'Finance', 'Development', 'Data', 'Risk management']

    departments.each do |dept|
      Department.create!(name: dept)
    end
  end
  def down
    Department.destroy_all
  end
end
