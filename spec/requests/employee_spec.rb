# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Employee", type: :request do
  describe "request list of all employees" do
    before(:each) do
      session = { valid: true }
      allow_any_instance_of(EmployeesController).to receive(:session).and_return(session)
    end

    it 'lists employees with edit delete buttons after manage -> sign in' do
      create :department
      emp = create :employee

      get employees_url
      expect(response).to be_successful
      expect(response.body).to include(emp.name)
      expect(response.body).to include(Department.find(emp.department_id).name)
      expect(response.body).to include('<input type="submit" value="Delete"')
      expect(response.body).to include('class="btn btn-primary">Edit</a>')
    end

    it 'creates employee' do
      create_list(:department, 7)
      dept = Department.first
      create_list(:employee, 21)

      LunchPartner.create_mystery_lunches(Date.today)
      expect do
        post employees_url, params: { employee: { name: "roni", department_id: dept.id, image: Rack::Test::UploadedFile.new('spec/support/test_image.png', 'image/png'), department: Department.all.sample } }
      end.to change { LunchPartner.count }.by(1)
      expect(response).to redirect_to(employees_path)
    end

    it 'edits employee ' do
      create_list(:department, 7)
      create_list(:employee, 21)
      emp_to_edit = Employee.last
      name = 'Tyson'

      patch "/employees/#{emp_to_edit.id}", params: {employee: {id: emp_to_edit.id, name: name}}
      emp_to_edit.reload

      expect(emp_to_edit.name).to eq(name)
    end

    it 'marks employee for deletion and shifts lone partner to another group' do
      create_list(:department, 7)
      create_list(:employee, 6)
      emp_to_delete = Employee.last

      LunchPartner.create_mystery_lunches(Date.today)
      partners = Employee.fetch_partners(emp_to_delete.id)
      partners_group_before = LunchPartner.where(employee_id: partners).pluck(:lunch_group_id)

      expect do
        delete "/employees/#{emp_to_delete.id}", params: { id: emp_to_delete.id }
      end.to change { LunchPartner.count }.by(-1)

      emp_to_delete.reload
      expect(emp_to_delete.to_delete).to be_truthy

      partners_group_after = LunchPartner.where(employee_id: partners).pluck(:lunch_group_id)
      expect(partners_group_before).to_not match_array(partners_group_after)
    end

    it 'marks employee for deletion and does not shifts partner, when part of 3 people mystery lunch' do
      create_list(:department, 7)
      create_list(:employee, 3)
      emp_to_delete = Employee.last

      LunchPartner.create_mystery_lunches(Date.today)
      partners = Employee.fetch_partners(emp_to_delete.id)
      partners_group_before = LunchPartner.where(employee_id: partners).pluck(:lunch_group_id)

      expect do
        delete "/employees/#{emp_to_delete.id}", params: { id: emp_to_delete.id }
      end.to change { LunchPartner.count }.by(-1)

      emp_to_delete.reload
      expect(emp_to_delete.to_delete).to be_truthy

      partners_group_after = LunchPartner.where(employee_id: partners).pluck(:lunch_group_id)
      expect(partners_group_before).to match_array(partners_group_after)
    end
  end
end