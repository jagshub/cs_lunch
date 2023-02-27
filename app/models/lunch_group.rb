# == Schema Information
#
# Table name: lunch_groups
#
#  id         :bigint           not null, primary key
#  lunch_date :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class LunchGroup < ApplicationRecord
  has_many :lunch_partners
  has_many :employees, :through => :lunch_partners, dependent: :destroy

  scope :created_this_month, lambda {where("created_at >= ? AND created_at <= ?", Time.now.beginning_of_month, Time.now.end_of_month)}
  scope :created_1_month_ago, lambda {where("created_at >= ? AND created_at <= ?", (Time.now - 1.month).beginning_of_month, (Time.now - 1.month).end_of_month)}
  scope :created_2_month_ago, lambda {where("created_at >= ? AND created_at <= ?", (Time.now - 2.month).beginning_of_month, (Time.now - 2.month).end_of_month)}
  scope :created_3_month_ago, lambda {where("created_at >= ? AND created_at <= ?", (Time.now - 3.month).beginning_of_month, (Time.now - 3.month).end_of_month)}
end
