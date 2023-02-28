class PartnersController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
    @all_previous_partners = Employee.fetch_previous_partners(@employee)
  end
end