class WorktimesController < ApplicationController
	def create
		@worktime = employee_current_user.worktimes.build()
	    @worktime.checkin = Time.now
	    @office = Office.find(employee_current_user.office_id)
	    
	    if (params[:latitude].to_f > @office.latitude_min) && (params[:latitude].to_f < @office.latitude_max &&
	    	params[:longitude].to_f > @office.longitude_min) && (params[:longitude].to_f < @office.longitude_max)
	    	@worktime.place_checkin = @office.name
	    	@worktime.save
	    else
	    	@offices = Office.where("company_id = ? AND id <> ?", @office.company_id, @office.id)
	    	@offices.each  do | o |
	    		if (params[:latitude].to_f > o.latitude_min) && (params[:latitude].to_f < o.latitude_max &&
	    			params[:longitude].to_f > o.longitude_min) && (params[:longitude].to_f < o.longitude_max)
	    			@worktime.place_checkin = o.name
	    			@worktime.save
	    			break
	    		end
	    	end
	    end
	    redirect_to :back
	end

	def update
		@worktime = Worktime.find_by_employee_id(employee_current_user, :limit => 1, :order => 'created_at desc')
		@office = Office.find(employee_current_user.office_id)
	    if (params[:latitude].to_f > @office.latitude_min) && (params[:latitude].to_f < @office.latitude_max &&
	    	params[:longitude].to_f > @office.longitude_min) && (params[:longitude].to_f < @office.longitude_max)
			@worktime.update_attribute('checkout',Time.now)
			@worktime.update_attribute('place_checkout',@office.name)
	    else
	    	@offices = Office.where("company_id = ? AND id <> ?", @office.company_id, @office.id)
	    	@offices.each  do | o |
	    		if (params[:latitude].to_f > o.latitude_min) && (params[:latitude].to_f < o.latitude_max &&
	    			params[:longitude].to_f > o.longitude_min) && (params[:longitude].to_f < o.longitude_max)
					@worktime.update_attribute('checkout',Time.now)
					@worktime.update_attribute('place_checkout',o.name)
	    			break
	    		end
	    	end
	    end
      	redirect_to :back
    end
end
