# == Schema Information
#
# Table name: employees
#
#  id            :bigint           not null, primary key
#  age           :string
#  email         :string
#  image_url     :string
#  name          :string
#  sex           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  department_id :bigint
#
# Indexes
#
#  index_employees_on_department_id  (department_id)
#
class Employee < ApplicationRecord

  belongs_to :department
  has_many :lunch_groups
  has_many :lunch_partners, :through => :lunch_groups

  has_one_attached :image


  class << self
    # Jag: Find a group, so that depts of every employee is different
    def find_lunch_group(emp_departments_in_groups, dept_of_emp_to_pair)
      emp_departments_in_groups.each do |k,v|
        return k unless v.include? dept_of_emp_to_pair
      end
    end

    def fetch_previous_partners(emp_id)
      last_3_months_lunch_groups = LunchPartner.created_in_last_3_months.where(employee_id: emp_id).pluck(:lunch_group_id)
      last_3_months_partners = []
      last_3_months_partners << LunchPartner.where(lunch_group_id: last_3_months_lunch_groups).where.not(employee_id: emp_id).pluck(:employee_id)
      last_3_months_partners.flatten
    end

    def fetch_partners(emp_id)
      lunch_groups = LunchPartner.created_this_month.where(employee_id: emp_id).pluck(:lunch_group_id)
      partners = []
      partners << LunchPartner.where(lunch_group_id: lunch_groups).where.not(employee_id: emp_id).pluck(:employee_id)
      partners.flatten
    end
  end
end
