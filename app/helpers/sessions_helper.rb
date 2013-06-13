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
end