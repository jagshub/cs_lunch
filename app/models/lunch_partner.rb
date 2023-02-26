# == Schema Information
#
# Table name: lunch_partners
#
#  id             :bigint           not null, primary key
#  month          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  department_id  :bigint
#  employee_id    :bigint           not null
#  lunch_group_id :bigint           not null
#
# Indexes
#
#  idx_emp_group                           (employee_id,lunch_group_id) UNIQUE
#  idx_emp_month                           (employee_id,month) UNIQUE
#  index_lunch_partners_on_department_id   (department_id)
#  index_lunch_partners_on_employee_id     (employee_id)
#  index_lunch_partners_on_lunch_group_id  (lunch_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (employee_id => employees.id)
#  fk_rails_...  (lunch_group_id => lunch_groups.id)
#
class LunchPartner < ApplicationRecord

  belongs_to :employee
  belongs_to :lunch_group

  scope :created_in_last_3_months, lambda {where("created_at > ? AND created_at < ?", (Time.now - 3.month).beginning_of_month, Time.now.end_of_month)}
  scope :created_this_month, lambda {where("created_at > ? AND created_at < ?", Time.now.beginning_of_month, Time.now.end_of_month)}

  class << self
    def create_mystery_lunches(dt)
      emp_arr = Employee.all.pluck(:id)
      partnered_ids = []

      (Employee.count / 2).times do
        emp_id = emp_arr.pop

        grp = LunchGroup.create!(lunch_date: Utils::first_friday(dt), created_at: dt)

        emp = Employee.find(emp_id)
        LunchPartner.create(lunch_group: grp, employee: emp, department_id: emp.department.id, month: dt.strftime('%B'), created_at: dt)
        partnered_ids << emp_id

        last_3_months_partners = Employee.fetch_previous_partners(emp_id)
        pair = Employee.where.not('department_id = ?', Employee.find(emp_id).department_id).where.not(id: last_3_months_partners).where.not(id: partnered_ids).pluck(:id).sample
        emp = pair.nil? ? Employee.all.sample : Employee.find(pair)
        LunchPartner.create(lunch_group: grp, employee: emp, department_id: emp.department.id, month: dt.strftime('%B'), created_at: dt)
        partnered_ids << pair

        emp_arr = emp_arr - partnered_ids
      end

      # When employees count is odd
      unless emp_arr.empty?
        emp = Employee.find(emp_arr.pop)
        emp_departments_in_groups = LunchPartner.where("created_at > ? AND created_at < ?", dt.beginning_of_month, dt.end_of_month).pluck(:lunch_group_id, :department_id).group_by(&:shift).transform_values(&:flatten)
        group = LunchGroup.find(Employee.find_lunch_group(emp_departments_in_groups, emp.department.id))
        LunchPartner.create(lunch_group: group, employee: emp, department_id: emp.department.id, month: dt.strftime('%B'), created_at: dt)
      end
    end

    def create_mystery_lunch_for_current_month
      return if LunchPartner.where(month: Date.today.strftime('%B')).count > 0
      pp "-----------------------------------------"
      pp "Generating mystery lunches: #{Date.today}"
      pp "-----------------------------------------"
      LunchPartner.create_mystery_lunches(Date.today)
    end
  end
end
