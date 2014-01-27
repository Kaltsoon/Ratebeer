class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :currently_signed_in?
  def current_user
  	return User.find_by_id(session[:user_id])
  end
  def currently_signed_in?(user)
  	return current_user==user
  end
end
