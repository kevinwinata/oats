class EmployeesController < ApplicationController
  
  def new
    @employee = Employee.new
  end

  def show
  	@employee = Employee.find(params[:id])
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
end
