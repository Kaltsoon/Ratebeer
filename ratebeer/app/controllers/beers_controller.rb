class BeersController < ApplicationController
  # GET /beers
  # GET /beers.json
  before_filter :ensure_that_signed_in, only: [:new, :create, :edit, :update, :destroy]
  before_filter :initialize_form, only: [:new, :edit, :update, :create]
  before_filter :skip_if_cached, only: [:index]

  def skip_if_cached
    return render :index if fragment_exist?("beerlist")
  end

  def initialize_form
    @beer = Beer.new
    @breweries=Brewery.all
    @styles=Style.all
  end

  def list
  end

  def index
    @beers = Beer.includes(:style,:brewery).all.sort_by{ |b| b.send(params[:order] || 'name') }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beers, methods: [:brewery, :style] }
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
    @beer=Beer.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer }
    end
  end

  # GET /beers/1/edit
  def edit
    @beer=Beer.find(params[:id])
  end

  # POST /beers
  # POST /beers.json
  def create
    expire_fragment('beerlist')
    @beer = Beer.new(params[:beer])
    if(@beer.save)
      redirect_to beers_path
    else
      render :new
    end
  end

  # PUT /beers/1
  # PUT /beers/1.json
  def update
    expire_fragment('beerlist')
    @beer = Beer.find(params[:id])
    if(@beer.update_attributes(params[:beer]))
      redirect_to beer_path(@beer)
    else
      render :edit
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    expire_fragment('beerlist')
    @beer = Beer.find(params[:id])
    @beer.destroy

    respond_to do |format|
      format.html { redirect_to beers_url }
      format.json { head :no_content }
    end
  end
end
