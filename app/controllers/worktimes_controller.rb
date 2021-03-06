class WorktimesController < ApplicationController

	def create
		if (params[:mobile_number].nil?)
			@worktime = employee_current_user.worktimes.build()
		    @office = Office.find(employee_current_user.office_id)
		    @worktime.checkin = Time.now
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
		else
			@employee = Employee.find_by_mobile_number(params[:mobile_number])
			if @employee.nil?
				render :json => { :code => '501', :time => '0' }
			else
				if (@employee.checkin?(@employee))
					render :json => { :code => '505', :time => '0' }
				else
					@worktime = @employee.worktimes.build()
				    @office = Office.find(@employee.office_id)
				    @worktime.checkin = Time.now
				    if (params[:latitude].to_f > @office.latitude_min) && (params[:latitude].to_f < @office.latitude_max &&
				    	params[:longitude].to_f > @office.longitude_min) && (params[:longitude].to_f < @office.longitude_max)
				    	@worktime.place_checkin = @office.name
				    	if @worktime.save
		    				render :json => { :code => '200', :time => Time.now }
		    			else
		    				render :json => { :code => '503', :time => '0' }
		    			end
				    else
				    	@offices = Office.where("company_id = ? AND id <> ?", @office.company_id, @office.id)
				    	found = false;
				    	@offices.each  do | o |
				    		if (params[:latitude].to_f > o.latitude_min) && (params[:latitude].to_f < o.latitude_max &&
				    			params[:longitude].to_f > o.longitude_min) && (params[:longitude].to_f < o.longitude_max)
				    			@worktime.place_checkin = o.name
				    			if @worktime.save
				    				render :json => { :code => '200', :time => Time.now }
				    			else
				    				render :json => { :code => '503', :time => '0' }
				    			end
				    			found = true
				    			break
				    		end
				    	end
				    	if !found
				    		render :json => { :code => '502', :time => '0' }
				    	end
				    end
				end
			end
		end
	end

	def update
		if (params[:mobile_number].nil?)
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
		else
			@employee = Employee.find_by_mobile_number(params[:mobile_number])
			if @employee.nil?
				render :json => { :code => '501', :time => '0' }
			else
				if (!@employee.checkin?(@employee))
					render :json => { :code => '505', :time => '0' }
				else
					@worktime = Worktime.find_by_employee_id(@employee, :limit => 1, :order => 'created_at desc')
					@office = Office.find(@employee.office_id)
				    if (params[:latitude].to_f > @office.latitude_min) && (params[:latitude].to_f < @office.latitude_max &&
				    	params[:longitude].to_f > @office.longitude_min) && (params[:longitude].to_f < @office.longitude_max)
				    	if @worktime.update_attribute('checkout',Time.now) && @worktime.update_attribute('place_checkout',@office.name)
		    				render :json => { :code => '200', :time => Time.now }
		    			else
		    				render :json => { :code => '503', :time => '0' }
		    			end
				    else
				    	@offices = Office.where("company_id = ? AND id <> ?", @office.company_id, @office.id)
				    	found = false
				    	@offices.each  do | o |
				    		if (params[:latitude].to_f > o.latitude_min) && (params[:latitude].to_f < o.latitude_max &&
				    			params[:longitude].to_f > o.longitude_min) && (params[:longitude].to_f < o.longitude_max)
								if @worktime.update_attribute('checkout',Time.now) && @worktime.update_attribute('place_checkout',o.name)
				    				render :json => { :code => '200', :time => Time.now }
				    			else
				    				render :json => { :code => '503', :time => '0' }
				    			end
				    			found = true
				    			break
				    		end
				    	end
				    	if !found
				    		render :json => { :code => '502', :time => '0' }
				    	end
				    end
				end
			end
		end
    end
end