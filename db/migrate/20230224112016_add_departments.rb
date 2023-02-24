class AddDepartments < ActiveRecord::Migration[6.1]
  def change
    departments = ['Marketing', 'Sales', 'Support', 'Operations', 'HR', 'Legal', 'Finance']

    departments.each do |dept|
      Department.create!(name: dept)
    end
  end
end
