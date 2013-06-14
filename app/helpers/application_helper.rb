module ApplicationHelper

	def static_page_header(desc)
  		if desc == 'dynamic'
  			render 'layouts/header'
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
