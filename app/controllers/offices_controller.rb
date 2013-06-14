class OfficesController < ApplicationController
  before_filter :signed_in_company, only: [:create, :destroy]
  before_filter :company_correct_user,   only: :destroy

  def index
  end

  def create
  	@office = company_current_user.offices.build(params[:office])
    if @office.save
      redirect_to @company_current_user
    else
      redirect_to '/company/signin'
    end
  end

  def destroy
    @office.destroy
    redirect_to @company_current_user
  end

  private

    def company_correct_user
      @office = company_current_user.offices.find_by_id(params[:id])
      redirect_to @company_current_user if @office.nil?
    end
end