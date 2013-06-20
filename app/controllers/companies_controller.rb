class CompaniesController < ApplicationController
  before_filter :signed_in_company, only: [:edit, :update, :edit_employee, :show]
  before_filter :correct_company,   only: [:edit, :update]
  before_filter :right_company, only: [:edit_employee]
  before_filter :admin, only: [:index, :destroy]

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
    cookies[:url] = request.fullpath
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to :back
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

  def edit_employee
    @employee = Employee.find(params[:id])
    cookies[:url] = request.fullpath
  end

  private

    def correct_company
      @company = Company.find(params[:id])
      redirect_to(@company_current_user) unless company_current_user?(@company)
    end

    def right_company
      @employee = Employee.find(params[:id])
      @company = Company.find_by_id(Office.find_by_id(@employee.office_id).company_id)
      redirect_to(@company_current_user) unless company_current_user?(@company)
    end

    def admin
      if company_signed_in?
        redirect_to company_current_user unless (company_current_user.id == 1)
      else
        redirect_to '/company/signin'
      end
    end

end
