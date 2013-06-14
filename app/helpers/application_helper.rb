module ApplicationHelper

	def static_page_header(desc, role)
  		if desc == 'dynamic'
  			if role == 'company'
	  			render 'layouts/header'
  			elsif role == 'employee'
  				render 'layouts/header_employee'
  			else role
  				render 'layouts/header_HR'
  			end
  		else
    		
  		end
	end

	def static_page_footer(desc)
  		if desc == 'none'

  		else
    		render 'layouts/footer'
  		end
	end
end
