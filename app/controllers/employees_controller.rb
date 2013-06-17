class EmployeesController < ApplicationController
  before_filter :signed_in_employee, only: [:edit, :update, :index]
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
        redirect_to '/employees'
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
    cookies[:url] = request.fullpath
  end

  def update
    @employee = Employee.find(params[:id])
    if cookies[:url].include?'/company/edit_employee'
      @employee.update_attribute('role',params[:employee][:role])
      @employee.update_attribute('office_id',params[:employee][:office_id])
      redirect_to company_current_user
    else
      if @employee.update_attributes(params[:employee].except(:role))
        employee_sign_in @employee
        redirect_to @employee
      else
        render 'edit'
      end
    end
    cookies.delete :url
  end

  def destroy
    Employee.find(params[:id]).destroy
    redirect_to :back
  end

  private

    def signed_in_employee
      unless company_signed_in?
        redirect_to '/employee/signin' unless employee_signed_in?  
      end
    end

    def correct_employee
      @employee = Employee.find(params[:id])
      unless company_signed_in?
        redirect_to(@employee_current_user) unless employee_current_user?(@employee)
      end
    end

    def hr_employee
      redirect_to(@employee_current_user) unless employee_current_user.role?
    end
end
