class SessionCompaniesController < ApplicationController
  def new
  end

  def create
    company = Company.find_by_username(params[:session][:username].downcase)
    if company && company.authenticate(params[:session][:password])
      sign_in company
      redirect_to company
      flash.now[:error] = 'Invalid email/password combination'
    else
      flash.now[:error] = 'Invalid email/password combination'

      redirect_to '/companies'
    end
  end

  def destroy
  end
end
