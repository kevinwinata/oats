class SessionCompaniesController < ApplicationController
  def new
  end

  def create
    company = Company.find_by_username(params[:session][:username].downcase)
    if company && company.authenticate(params[:session][:password])
      company_sign_in company
      redirect_back_or company
    else
      render 'new'
    end
  end

  def destroy
    company_sign_out
    redirect_to '/company/signin'
  end
end
