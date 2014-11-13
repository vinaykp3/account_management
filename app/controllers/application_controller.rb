class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!  
  after_action :store_location, :except=> :sign_out_user
  

  def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  # return unless request.get? 
  # binding.pry
  # if (request.path != "/users/sign_in" &&
  #     request.path != "/users/sign_up" &&
  #     request.path != "/users/password/new" &&
  #     request.path != "/users/password/edit" &&
  #     request.path != "/users/confirmation" &&
  #     request.path != "/users/sign_out" &&
  #     !request.xhr?) # don't store ajax calls
  # #binding.pry
  #   session[:previous_url] = request.fullpath
    # redirect_to if user_signed_in?
   if current_user
   		$redis.set("user_#{current_user.id}", request.fullpath)
   end 
 end

	def after_sign_in_path_for(resource)
	  # session[:previous_url] || root_path
	  $redis.get("user_#{resource.id}") || root_path
	end

	# def after_sign_out_path_for(resource)
 #  		binding.pry
	# end
end
