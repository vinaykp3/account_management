class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!  
  after_action :store_location, :except=> :sign_out_user
  

  def store_location
   if current_user
   		$redis.set("user_#{current_user.id}", request.fullpath)
   end 
 end

	def after_sign_in_path_for(resource)
	  $redis.get("user_#{resource.id}") || root_path
	end
  
end
