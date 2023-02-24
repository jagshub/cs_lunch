# == Schema Information
#
# Table name: employees
#
#  id         :bigint           not null, primary key
#  age        :string
#  email      :string
#  name       :string
#  sex        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Employee < ApplicationRecord

  belongs_to :department

  has_one_attached :image
end
