# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Hompage", type: :request do
  describe " verify partners list" do
    it 'shows message when partners not generated for month' do
      create_list(:department, 7)
      create_list(:employee, 6)
      emp = Employee.first

      get root_url
      expect(response).to be_successful
      expect(response.body).to include('Mystery lunch to be generated for month')
    end

    it 'lists partners for this month' do
      create_list(:department, 7)
      create_list(:employee, 6)
      emp_names = Employee.all.pluck(:name)

      LunchPartner.create_mystery_lunches(Date.today)

      get root_url
      expect(response).to be_successful
      expect(response.body).to include('class="btn btn-primary">See all previous partners</a>')
      expect(response.body).to include('Filter by dept')
      expect(response.body).to include("Mystery Partners for #{Date.today.strftime('%B')}")

      emp_names.each do |name|
        expect(response.body).to include(name)
      end
    end
  end
end
