class HomeController < ApplicationController
  def index
    @employees = params[:dept].nil?? Employee.where(to_delete: false) : Employee..where(to_delete: false).where(department_id: params[:dept])
    @dept_name = params[:dept].nil?? 'All' : Department.find(params[:dept]).name
    @partners = []
  end

  def signout
    session[:valid] = nil
    redirect_to(login_url)
  end
end