class RatingsController < ApplicationController
  def index
    @ratings=Rating.all
  	render :index
  end
  def new
  	@beers=Beer.all
  	@rating = Rating.new
  	render :new
  end
  def create
  	Rating.create params[:rating]
  	redirect_to beers_path
  end
  def destroy
  	rating=Rating.find(params[:id])
  	rating.delete
  	redirect_to(ratings_path)
  end
end