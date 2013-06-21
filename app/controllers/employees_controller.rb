class EmployeesController < ApplicationController
  before_filter :signed_in_employee, only: [:edit, :update, :index]
  before_filter :correct_employee,   only: [:edit, :update]
  before_filter :hr_employee,     only: :index

  def new
    @employee = Employee.new
    cookies[:url] = request.fullpath
  end

  def show
    unless Worktime.find_by_employee_id(employee_current_user, :limit => 1, :order => 'created_at desc').nil?
      @timer = (Time.now - Worktime.find_by_employee_id(employee_current_user, :limit => 1, :order => 'created_at desc').checkin).to_i
    end
    @employee = Employee.find(params[:id])
    @worktimes = @employee.worktimes
    @worktime = Worktime.find_by_employee_id(@employee, :limit => 1, :order => 'created_at desc')
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

  def reset_pass
    @employee = Employee.find(params[:id])
    cookies[:url] = request.fullpath
  end

  def edit_employee
    @employee = Employee.find(params[:id])
    cookies[:url] = request.fullpath
  end

  def edit
    @employee = Employee.find(params[:id])
    cookies[:url] = request.fullpath
  end

  def update
    @employee = Employee.find(params[:id])
    if (cookies[:url].include?'/companies') && company_signed_in?
      @employee.update_attribute('role',params[:employee][:role])
      @employee.update_attribute('office_id',params[:employee][:office_id])
      redirect_to company_current_user
    elsif employee_current_user.role? && (cookies[:url].include?'/employee/edit_employee') 
      if (Employee.valid_name?(params[:employee][:name]) && 
        Employee.valid_mobile_number?(@employee,params[:employee][:mobile_number]) && 
        Employee.valid_office_id?(@employee,params[:employee][:office_id]))
        @employee.update_attribute('name',params[:employee][:name])
        @employee.update_attribute('division',params[:employee][:division])
        @employee.update_attribute('mobile_number',params[:employee][:mobile_number])
        @employee.update_attribute('office_id',params[:employee][:office_id])
        redirect_to '/employees'
      else
        redirect_to :back
      end
    elsif employee_current_user.role? && (cookies[:url].include?'/employee/reset_pass') 
        if @employee.update_attributes(params[:employee])
          redirect_to '/employees'
        else
          redirect_to :back
        end
    else
      if @employee.authenticate(params[:employee][:old_password]) && Employee.valid_password?(params[:employee][:password], params[:employee][:password_confirmation])
        if @employee.update_attribute('password', params[:employee][:password]) && @employee.update_attribute('password_confirmation', params[:employee][:password_confirmation])
          employee_sign_in @employee
          redirect_to @employee
        else
          redirect_to :back
        end
      else
        redirect_to :back
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
      if employee_signed_in?
        redirect_to(@employee_current_user) unless employee_current_user.role?
      else
        redirect_to '/employee/signin'
      end
    end
end
