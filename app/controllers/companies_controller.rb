class CompaniesController < ApplicationController
  include ActionController::MimeResponds
  include ActionController::Helpers
  include ActionController::Cookies
  
  def new
  end

  def create
  @company = Company.new(params[:company])
  @company.save
end
  end

  def index
  	@companies = Company.all
  	respond_to do |format|
  		format.html
  		format.json
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
