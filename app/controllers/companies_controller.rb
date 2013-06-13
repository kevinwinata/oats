class CompaniesController < ApplicationController
  include ActionController::MimeResponds
  include ActionController::Helpers
  include ActionController::Cookies
  
  def index
  	@companies = Company.all
  	respond_to do |format|
  		format.html
  		format.json { render }
  	end
  end

  def show
  	@company = Company.find(params[:id])
  	respond_to do |format|
  		format.html
  		format.json
  	end
  end
end
