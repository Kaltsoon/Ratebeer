class RatingsController < ApplicationController
  def index
    @ratings=Rating.all
  	render :index
  end
  def new
    if(current_user.nil?)
      redirect_to signin_path
    else
    	@beers=Beer.all
    	@rating = Rating.new
    	render :new
    end
  end
  def create
    if(current_user.nil?)
      redirect_to signin_path
    else
    	@rating=Rating.new params[:rating]
      @rating.user=current_user
      if(@rating.save)
    	   redirect_to user_path(current_user)
      else
        @beers=Beer.all
        render :new
      end
    end
  end
  def destroy
  	rating=Rating.find(params[:id])
    if(currently_signed_in?(rating.user))
  	 rating.delete
  	end
    redirect_to :back
  end
end