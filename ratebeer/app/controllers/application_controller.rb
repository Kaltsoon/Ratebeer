class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :currently_signed_in?, :ensure_that_signed_in
  def current_user
  	return User.find_by_id(session[:user_id])
  end
  def currently_signed_in?(user)
  	return current_user==user
  end
  def ensure_that_signed_in
  	redirect_to signin_path, notice: "you should be signed in" if current_user.nil?
  end
  def ensure_that_admin
  	return (current_user==nil ? false : current_user.admin)
  end
end
