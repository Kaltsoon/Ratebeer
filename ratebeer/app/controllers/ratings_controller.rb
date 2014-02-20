class RatingsController < ApplicationController
  before_filter :ensure_that_signed_in, only: [:new, :create]
  def index
    @ratings=Rating.all
    @latest_ratings=Rating.latest
    @best_beers=Beer.highest_ratings
    @best_breweries=Brewery.highest_ratings
    @best_styles=Style.highest_ratings
    @most_active_users=User.most_ratings
  end
  def new
    if(current_user.nil?)
      redirect_to signin_path
    else
    	@beers=Beer.all
    	@rating = Rating.new
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