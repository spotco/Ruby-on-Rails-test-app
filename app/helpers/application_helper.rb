module ApplicationHelper

	def title
		base_title = "Mon Test"
		
		if @title.nil?
			return base_title
		else 
			return "#{base_title} | #{@title}"
		end
	end
	
	def logo
		image_tag("textpreview.php.gif", :alt =>"Sample App", :class=> "round")
	end
	
end
