class CompaniesController < ApplicationController
  before_filter :company_signed_in, only: [:edit, :update, :show]

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
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      company_sign_in @company
      redirect_to @company
    else
      render 'edit'
    end
  end

  private

    def company_signed_in
      redirect_to '/company/signin' unless company_signed_in?
    end
end
