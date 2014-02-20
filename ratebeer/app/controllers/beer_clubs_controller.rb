class BeerClubsController < ApplicationController
  # GET /beer_clubs
  # GET /beer_clubs.json
  before_filter :ensure_that_signed_in, only: [:new, :create, :edit, :destroy, :update]
  before_filter :initialize_form, only: [:join_to_a_club, :joining_club]
  def index
    @beer_clubs = BeerClub.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @beer_clubs }
    end
  end

  # GET /beer_clubs/1
  # GET /beer_clubs/1.json
  def show
    @beer_club = BeerClub.find(params[:id])
    if(not current_user.nil?)
      memberships=Membership.where(user_id: current_user.id, beer_club_id: params[:id])
      @membership=(memberships.empty? ? nil : memberships.first)
    else
      @membershi=nil
    end
  end
  # GET /beer_clubs/new
  # GET /beer_clubs/new.json
  def new
    @beer_club = BeerClub.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @beer_club }
    end
  end

  # GET /beer_clubs/1/edit
  def edit
    @beer_club = BeerClub.find(params[:id])
  end

  # POST /beer_clubs
  # POST /beer_clubs.json
  def create
    @beer_club = BeerClub.new(params[:beer_club])
    if @beer_club.save
      Membership.create(beer_club_id: @beer_club.id, user_id: current_user.id, confirmed: true)
      redirect_to @beer_club, notice: 'Beer club was successfully created.'
    else
      render :new
    end
  end

  # PUT /beer_clubs/1
  # PUT /beer_clubs/1.json
  def update
    @beer_club = BeerClub.find(params[:id])
    respond_to do |format|
      if @beer_club.update_attributes(params[:beer_club])
        format.html { redirect_to @beer_club, notice: 'Beer club was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @beer_club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beer_clubs/1
  # DELETE /beer_clubs/1.json
  def destroy
    @beer_club = BeerClub.find(params[:id])
    @beer_club.destroy

    respond_to do |format|
      format.html { redirect_to beer_clubs_url }
      format.json { head :no_content }
    end
  end
  
  private

  def initialize_form
    @clubs=BeerClub.all
  end
end
