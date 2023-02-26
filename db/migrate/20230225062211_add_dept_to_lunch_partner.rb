class AddDeptToLunchPartner < ActiveRecord::Migration[6.1]
  def change
    add_reference :lunch_partners, :department
  end
end