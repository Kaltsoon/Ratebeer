class MembershipsController < ApplicationController
  # GET /memberships
  # GET /memberships.json
  def index
    @memberships = Membership.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @memberships }
    end
  end

  # GET /memberships/1
  # GET /memberships/1.json
  def show
    @membership = Membership.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @membership }
    end
  end

  # GET /memberships/new
  # GET /memberships/new.json
  def new
    @membership = Membership.new
    @clubs=BeerClub.all
  end

  # GET /memberships/1/edit
  def edit
    @membership = Membership.find(params[:id])
  end

  # POST /memberships
  # POST /memberships.json
  def create
    club=BeerClub.find params[:club_id]
    user=current_user
    if(user==nil)
      redirect_to :root
    else
      @membership=Membership.new(user_id: user.id, beer_club_id: club.id)
      if(@membership.save)
        redirect_to beer_club_path(club), notice: "#{user}, welcome to the club!"
      else
        @clubs=BeerClub.all
        render :new
      end 
    end
  end

  # PUT /memberships/1
  # PUT /memberships/1.json
  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to @membership, notice: 'Membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memberships/1
  # DELETE /memberships/1.json
  def destroy
    if(not current_user.nil?)
      @membership = Membership.find(params[:id])
      @membership.destroy
      redirect_to beer_club_path(@membership.beer_club)
    end
  end
end
