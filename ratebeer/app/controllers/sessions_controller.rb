class SessionsController < ApplicationController
	def new
		render :signin
	end
	def create
		user=User.find_by_username(params[:username])
		if(user==nil)
			redirect_to "/signin", notice: "Wrong username or password!"
			return
		end
		session[:user_id]=user.id
		redirect_to user_path(user)
	end
	def destroy
		session[:user_id]=nil
		redirect_to "/"
	end
end