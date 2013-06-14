class CompaniesController < ApplicationController
  before_filter :signed_in_company, only: [:edit, :update, :show]
  before_filter :correct_company,   only: [:edit, :update]

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      company_sign_in @company
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
  end


  def update
    if @company.update_attributes(params[:company])
      company_sign_in @company
      redirect_to @company
    else
      render 'edit'
    end
  end

  private

    def signed_in_company
      unless company_signed_in?
        store_location
        redirect_to '/company/signin' 
      end
    end

    def correct_company
      @company = Company.find(params[:id])
      redirect_to(@company_current_user) unless company_current_user?(@company)
    end
end
