class SessionEmployeesController < ApplicationController
  def new
  end

  def create
    unless employee_signed_in? do
      employee = Employee.find_by_email(params[:session][:email].downcase)
      if employee && employee.authenticate(params[:session][:password])
        employee_sign_in employee
        redirect_to employee
      else
        render 'new'
      end
    end
  end

  def destroy
    employee_sign_out
    redirect_to '/employee/signup'
  end
end
