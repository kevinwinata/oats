module ApplicationHelper

	def static_page(desc)
  		if desc == 'static'
  	
  		else
    		render 'layouts/header'
  		end
	end
end
