class BreweriesController < ApplicationController
  # GET /breweries
  # GET /breweries.json
  before_filter :ensure_that_signed_in, only: [:new, :create, :edit, :update]
  before_filter :ensure_that_admin, only: [:destroy]

  def index
    @breweries = Brewery.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @breweries }
    end
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
    @brewery = Brewery.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brewery }
    end
  end

  # GET /breweries/new
  # GET /breweries/new.json
  def new
    @brewery = Brewery.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brewery }
    end
  end

  # GET /breweries/1/edit
  def edit
    @brewery = Brewery.find(params[:id])
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(params[:brewery])
    if(params[:brewery][:year].to_i>Time.now.year)
      @brewery.errors[:base]="Year can't be past current year!"
      render :edit
      return
    end
    if(@brewery.save)
      redirect_to brewery_path(@brewery)
    else
      render :new
    end
  end

  # PUT /breweries/1
  # PUT /breweries/1.json
  def update
    @brewery = Brewery.find(params[:id])
    if(params[:brewery][:year].to_i>Time.now.year)
      @brewery.errors[:base]="Year can't be past current year!"
      render :edit
      return
    end
    if(@brewery.update_attributes(year: params[:brewery][:year], name: params[:brewery][:name]))
      redirect_to brewery_path(@brewery)
    else
      render :edit
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery = Brewery.find(params[:id])
    @brewery.destroy

    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end
end
