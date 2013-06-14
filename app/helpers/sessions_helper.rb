module SessionsHelper

  def sign_in(company)
    cookies.permanent[:remember_company] = company.remember_company
    self.current_company = company
  end

  def signed_in?
    !current_company.nil?
  end

  def current_company=(company)
    @current_company = company
  end

  def current_company
    @current_company ||= Company.find_by_remember_company(cookies[:remember_company])
  end

  def sign_out
    self.current_company = nil
    cookies.delete(:remember_company)
  end

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