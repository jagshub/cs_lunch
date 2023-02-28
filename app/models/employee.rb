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
#  to_delete     :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  department_id :bigint
#
# Indexes
#
#  index_employees_on_department_id  (department_id)
#
class Employee < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :department
  has_many :lunch_partners
  has_many :lunch_groups, :through => :lunch_partners

  has_one_attached :image

  validates_presence_of :name, :department_id

  default_scope { where(to_delete: false).order(updated_at: :desc)}


  def get_image_url
    url_for(self.image)
  end

  class << self
    # Jag: Find a group, so that depts of every employee is different
    def find_lunch_group(emp_departments_in_groups, dept_of_emp_to_pair)
      emp_departments_in_groups.each do |k,v|
        return k if LunchGroup.created_this_month.count == 1
        next if LunchPartner.created_this_month.where(lunch_group_id: k).count > 2
        return k unless v.include? dept_of_emp_to_pair
      end
    end

    def fetch_previous_partners(emp_id, all = false)
      groups =  all ? LunchPartner.where(employee_id: emp_id).pluck(:lunch_group_id) :
                  LunchPartner.created_in_last_3_months.where(employee_id: emp_id).pluck(:lunch_group_id)
      partners = all ? LunchPartner.created_in_last_3_months.where(lunch_group_id: groups).where.not(employee_id: emp_id).pluck(:employee_id) : LunchPartner.where(lunch_group_id: groups).where.not(employee_id: emp_id).pluck(:employee_id)
      partners
    end

    def fetch_partners(emp_id)
      lunch_groups = LunchPartner.created_this_month.where(employee_id: emp_id).pluck(:lunch_group_id)
      partners =  LunchPartner.where(lunch_group_id: lunch_groups).where.not(employee_id: emp_id).pluck(:employee_id)
      partners
    end
  end
end
