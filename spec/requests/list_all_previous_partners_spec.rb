# frozen_string_literal: true
require 'rails_helper'

RSpec.describe "Previous Partners", type: :request do
  describe " verify partners list" do

    it 'lists all previous partners for this employee' do
      create_list(:department, 7)
      create_list(:employee, 6)
      emp = Employee.first

      LunchPartner.create_mystery_lunches(Date.today - 1.month)
      LunchPartner.create_mystery_lunches(Date.today)

      emp_ids = Employee.fetch_previous_partners(emp.id)

      get partners_path(emp.id)

      expect(response).to be_successful
      expect(response.body).to include("Previous Lunch partners")

      emp_ids.each do |id|
        expect(response.body).to include(Employee.find(id).name)
      end
    end
  end
end
