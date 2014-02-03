class SessionsController < ApplicationController
	def new
		render :signin
	end
	def create
		user=User.find_by_username(params[:username])
		if(user==nil || user.authenticate(params[:password])==false)
			redirect_to :back, notice: "username and password do not match"
			return
		end
		session[:user_id]=user.id
		redirect_to user_path(user), notice: "Welcome back!"
	end
	def destroy
		session[:user_id]=nil
		redirect_to "/"
	end
end