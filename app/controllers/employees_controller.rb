class EmployeesController < ApplicationController
  before_filter :signed_in_employee, only: [:edit, :update]
  before_filter :correct_employee,   only: [:edit, :update]
  before_filter :hr_employee,     only: :index

  def new
    @employee = Employee.new
  end

  def show
  	@employee = Employee.find(params[:id])
  end

  def index
    @employee = Employee.all
  end

  def create
    @employee = Employee.new(params[:employee])
    if @employee.save
      employee_sign_in @employee
      redirect_to @employee
    else
      render 'new'
    end
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
