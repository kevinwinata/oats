class EmployeesController < ApplicationController
  before_filter :signed_in_employee, only: [:edit, :update]
  before_filter :correct_employee,   only: [:edit, :update]
  before_filter :hr_employee,     only: :index

  def new
    @employee = Employee.new
    cookies[:url] = request.fullpath
  end

  def show
  	@employee = Employee.find(params[:id])
  end

  def index
    @company = Company.find_by_id(Office.find_by_id(employee_current_user.office_id).company_id)
    @employees = Employee.where("employees.office_id IN (SELECT offices.id FROM offices WHERE (company_id = ?))", @company.id)
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      if cookies[:url] == '/company/new_employee'
        redirect_to company_current_user
      else
        employee_sign_in @employee
        redirect_to @employee
      end
    else
      if cookies[:url] == '/company/new_employee'
        redirect_to '/company/new_employee'
      else
        render 'new'
      end
    end
    cookies.delete :url
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee].except(:role))
      employee_sign_in @employee
      redirect_to @employee
    else
      render 'edit'
    end
  end

  def update_all
    @employee = Employee.find(params[:id])
    if @employee.update_attributes(params[:employee])
      employee_sign_in @employee
      redirect_to @employee
    else
      render 'edit'
    end
  end

  def destroy
    Employee.find(params[:id]).destroy
    redirect_to company_current_user
  end

  private

    def signed_in_employee
      redirect_to '/employee/signin' unless employee_signed_in?
    end

    def correct_employee
      @employee = Employee.find(params[:id])
      redirect_to(@employee_current_user) unless employee_current_user?(@employee)
    end

    def hr_employee
      redirect_to('/employee/signin') unless employee_current_user.role?
    end
end
