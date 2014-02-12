class PlacesController < ApplicationController
	def index
	end
	def search
    	@places=BeermappingAPI.places_in(params[:city])
    	if(@places.empty?)
    		redirect_to places_path, notice: "No places in #{params[:city]}"
    	else
    		render :index
    	end
	end
	def show
		@place=BeermappingAPI.place_with_id(params[:id])
	end
end