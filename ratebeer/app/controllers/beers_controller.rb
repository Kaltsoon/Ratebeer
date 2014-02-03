class BeersController < ApplicationController
  # GET /beers
  # GET /beers.json
  before_filter :ensure_that_signed_in, only: [:new, :create, :edit, :update, :destroy]
  def index
    @beers = Beer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beers }
    end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    @beer = Beer.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/new
  # GET /beers/new.json
  def new
    @beer = Beer.new
	  @breweries=Brewery.all
	  @styles=["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/1/edit
  def edit
    @beer = Beer.find(params[:id])
    @styles=["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
    @breweries=Brewery.all
  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new(params[:beer])
    if(@beer.save)
      redirect_to beers_path
    else
      @breweries=Brewery.all
      @styles=["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
      render :new
    end
  end

  # PUT /beers/1
  # PUT /beers/1.json
  def update
    @beer = Beer.find(params[:id])
    if(@beer.update_attributes(params[:beer]))
      redirect_to beer_path(@beer)
    else
      @styles=["Weizen", "Lager", "Pale ale", "IPA", "Porter"]
      @breweries=Brewery.all
      render :edit
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    @beer = Beer.find(params[:id])
    @beer.destroy

    respond_to do |format|
      format.html { redirect_to beers_url }
      format.json { head :no_content }
    end
  end
end
