class WorktimesController < ApplicationController
	before_filter :signed_in_employee

	def create
		@worktime = employee_current_user.worktimes.build(params[:worktime])
	    @worktime.checkin = Time.now
	    @worktime.save
	    redirect_to :back
	end

	def update
		@worktime = Worktime.find_by_employee_id(employee_current_user, :limit => 1, :order => 'created_at desc')
		@worktime.update_attribute('checkout',Time.now)
		@worktime.update_attribute('place_checkout',params[:worktime][:place_checkout])
      	redirect_to :back
    end
end
