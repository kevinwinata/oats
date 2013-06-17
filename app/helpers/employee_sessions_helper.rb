module EmployeeSessionsHelper

  def employee_sign_in(employee)
    cookies.permanent[:remember_token] = employee.remember_token
    self.employee_current_user = employee
  end

  def employee_signed_in?
    !employee_current_user.nil?
  end

  def employee_current_user=(employee)
    @employee_current_user = employee
  end

  def employee_current_user
    @employee_current_user ||= Employee.find_by_remember_token(cookies[:remember_token])
  end

  def employee_current_user?(employee)
    employee == employee_current_user
  end

  def employee_sign_out
    self.employee_current_user = nil
    cookies.delete(:remember_token)
  end
end