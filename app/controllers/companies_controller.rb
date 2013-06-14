class CompaniesController < ApplicationController
  before_filter :signed_in_company, only: [:edit, :update]

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

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      sign_in @company
      redirect_to @company
    else
      render 'edit'
    end
  end

  private

    def signed_in_company
      redirect_to '/company/signin', notice: "Please sign in." unless signed_in?
    end
end
