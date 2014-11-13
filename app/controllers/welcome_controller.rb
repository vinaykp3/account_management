class WelcomeController < ApplicationController
	def index
		if request.referrer.nil?
	      redirect_to $redis.get("user_#{current_user.id}")
	    else  
	      redirect_to root_path
	    end
	end
end	