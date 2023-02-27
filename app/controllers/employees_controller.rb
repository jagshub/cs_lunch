class EmployeesController < ApplicationController

  before_action :set_employee, only: %i[ show edit update destroy ]

  def index
    if session[:valid]
      @msg = "logged in"
      @employees = Employee.unscoped.order(updated_at: :desc).all
    end
  end

  def new
    unless session[:valid]
      redirect_to(login_path)
    end
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(emp_params)
    @employee.save

    join_mystery_lunch
    redirect_to employees_path
  end

  def edit
    unless session[:valid]
      redirect_to(login_path)
    end
    @dept = @employee.department.name
  end

  def update
    respond_to do |format|
      if @employee.update(emp_params)
        format.html { redirect_to employees_path, notice: "Employee was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    unless session[:valid]
      redirect_to(login_path)
    end
    if params[:restore]
      @employee.update_attribute(:to_delete, false)
      join_mystery_lunch
    else
      @employee.update_attribute(:to_delete, true)
      dt = Date.today
      current_partners = Employee.fetch_partners(@employee.id)
      LunchPartner.where("created_at > ?", dt.beginning_of_month).where(employee_id: @employee.id).first&.destroy
      pp current_partners.size
      if current_partners.size < 2 && current_partners.size > 0
        partner = Employee.find(current_partners.pop)
        LunchPartner.where("created_at > ?", dt.beginning_of_month).where(employee_id: partner.id).first.destroy

        emp_departments_in_groups = LunchPartner.where("created_at > ? AND created_at < ?", dt.beginning_of_month, dt.end_of_month).pluck(:lunch_group_id, :department_id).group_by(&:shift).transform_values(&:flatten)
        group = LunchGroup.find(Employee.find_lunch_group(emp_departments_in_groups, partner.department.id))
        LunchPartner.create(lunch_group: group, employee: partner, department_id: partner.department.id, month: dt.strftime('%B'), created_at: dt)
      end
    end
      redirect_to(employees_path)
  end

  private

  def join_mystery_lunch
    dt = Date.today
    emp_departments_in_groups = LunchPartner.where("created_at > ? AND created_at < ?", dt.beginning_of_month, dt.end_of_month).pluck(:lunch_group_id, :department_id).group_by(&:shift).transform_values(&:flatten)
    group = LunchGroup.find(Employee.find_lunch_group(emp_departments_in_groups, @employee.department.id))
    LunchPartner.create(lunch_group: group, employee: @employee, department_id: @employee.department.id, month: dt.strftime('%B'), created_at: dt)
  end

  def set_employee
    @employee = Employee.unscoped.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def emp_params
    params.require(:employee).permit(:name, :image_url, :image, :department_id)
  end
end