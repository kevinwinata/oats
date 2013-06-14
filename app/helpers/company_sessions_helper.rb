module CompanySessionsHelper

  def company_sign_in(company)
    cookies.permanent[:remember_company] = company.remember_company
    self.company_current_user = company
  end

  def company_signed_in?
    !company_current_user.nil?
  end

  def company_current_user=(company)
    @company_current_user = company
  end

  def company_current_user
    @company_current_user ||= Company.find_by_remember_company(cookies[:remember_company])
  end

  def company_current_user?(company)
    company == company_current_user
  end

  def company_sign_out
    self.company_current_user = nil
    cookies.delete(:remember_company)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end