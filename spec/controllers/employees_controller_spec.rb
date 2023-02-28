require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do

  describe 'Manage requires login' do
    it 'redirects to login page' do
      get :new
      expect(response).to redirect_to(login_path)
    end

    it 'redirects to login page' do
      create :department
      emp = create :employee
      get :edit, :params => {id: emp.id}
      expect(response).to redirect_to(login_path)
    end

    it 'when signed in, shows create form' do
      session[:valid] = true
      get :new
      expect(response).to be_successful
      expect(response).to render_template("new")
    end

    it 'when signed in, shows edit form' do
      session[:valid] = true
      create :department
      emp = create :employee
      get :edit, :params => {id: emp.id}
      expect(response).to be_successful
      expect(response).to render_template("edit")
    end
  end
end
