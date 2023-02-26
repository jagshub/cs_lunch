# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#




# # Jag: Find a group, so that depts of every employee is different
# def find_lunch_group(emp_departments_in_groups, dept_of_emp_to_pair)
#   emp_departments_in_groups.each do |k,v|
#     return k unless v.include? dept_of_emp_to_pair
#   end
# end
#
# def fetch_previous_partners(emp_id)
#   last_3_months_lunch_groups = LunchPartner.created_in_last_3_months.where(employee_id: emp_id).pluck(:lunch_group_id)
#   last_3_months_partners = []
#   last_3_months_partners << LunchPartner.where(lunch_group_id: last_3_months_lunch_groups).where.not(employee_id: emp_id).pluck(:employee_id)
#   last_3_months_partners.flatten
# end
#
# def fetch_partners(emp_id)
#   lunch_groups = LunchPartner.created_this_month.where(employee_id: emp_id).pluck(:lunch_group_id)
#   partners = []
#   partners << LunchPartner.where(lunch_group_id: lunch_groups).where.not(employee_id: emp_id).pluck(:employee_id)
#   partners.flatten
# end
#
# def create_mystery_lunches(dt)
#     emp_arr = Employee.all.pluck(:id)
#     partnered_ids = []
#
#     (Employee.count / 2).times do
#       emp_id = emp_arr.pop
#
#       grp = LunchGroup.create!(lunch_date: Utils::first_friday(dt), created_at: dt)
#
#       emp = Employee.find(emp_id)
#       LunchPartner.create(lunch_group: grp, employee: emp, department_id: emp.department.id, month: dt.strftime('%B'), created_at: dt)
#       partnered_ids << emp_id
#
#       last_3_months_partners = fetch_previous_partners(emp_id)
#       pair = Employee.where.not('department_id = ?', Employee.find(emp_id).department_id).where.not(id: last_3_months_partners).where.not(id: partnered_ids).pluck(:id).sample
#       emp = Employee.find(pair)
#       LunchPartner.create(lunch_group: grp, employee: emp, department_id: emp.department.id, month: dt.strftime('%B'), created_at: dt)
#       partnered_ids << pair
#
#       emp_arr = emp_arr - partnered_ids
#     end
#
#     # When employees count is odd
#     unless emp_arr.empty?
#       emp = Employee.find(emp_arr.pop)
#       emp_departments_in_groups = LunchPartner.pluck(:lunch_group_id, :department_id).group_by(&:shift).transform_values(&:flatten)
#       group = LunchGroup.find(find_lunch_group(emp_departments_in_groups, emp.department.id))
#       LunchPartner.create(lunch_group: group, employee: emp, department_id: emp.department.id, month: dt.strftime('%B'), created_at: dt)
#     end
# end

# Generate some initial data like employees, mystery lunches with partners
LunchPartner.destroy_all
LunchGroup.destroy_all
Employee.destroy_all

# Jag: Create employees
31.times do |n|
  f_name = Faker::Name.first_name
  s_name = Faker::Name.last_name
  sex = ['Male', 'Female']
  Employee.create!(name: "#{f_name} #{s_name}", sex: sex[rand(0..1)], image_url: Faker::Avatar.image, department: Department.all.sample)
end

# Jag: Create a few mystery lunches in the past
[Date.today - 4.month, Date.today - 3.month, Date.today - 2.month, Date.today - 1.month].each do |dt|
  LunchPartner.create_mystery_lunches(dt)
end





