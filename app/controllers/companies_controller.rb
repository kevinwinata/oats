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
    @offices = @company.offices
    @employees = Employee.where("employees.office_id IN (SELECT offices.id FROM offices WHERE (company_id = ?))", @company.id)
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

  def new_employee
    @employee = Employee.new
    cookies[:url] = request.fullpath
  end

  private

    def correct_company
      @company = Company.find(params[:id])
      redirect_to(@company_current_user) unless company_current_user?(@company)
    end
end
