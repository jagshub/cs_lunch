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

  has_one_attached :image
end
