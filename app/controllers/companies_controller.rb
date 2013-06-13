class CompaniesController < ApplicationController
  
  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      sign_in @company
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @company
    else
      render 'new'
    end
  end

  def index
  	@companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end
end
