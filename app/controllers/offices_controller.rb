class OfficesController < ApplicationController
  include Math

  before_filter :signed_in_company, only: [:create, :destroy]
  before_filter :company_correct_user,   only: :destroy

  def index
  end

  def create
  	@office = company_current_user.offices.build(params[:office])
    delta_lat = params[:office][:range].to_f / 6378137 * 180 / Math::PI
    delta_long = 2 * Math.asin(Math.sin(params[:office][:range].to_f / 12756274) / Math.cos(params[:office][:latitude].to_f * Math::PI / 180)) * 180 / Math::PI
    @office.update_attribute('latitude_min', params[:office][:latitude].to_f - delta_lat)
    @office.update_attribute('latitude_max', params[:office][:latitude].to_f + delta_lat)
    @office.update_attribute('longitude_min', params[:office][:longitude].to_f - delta_long)
    @office.update_attribute('longitude_max', params[:office][:longitude].to_f + delta_long)
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