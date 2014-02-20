class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.includes(:ratings,:beer_clubs,:memberships).find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if(!currently_signed_in?(@user))
      redirect_to :root
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    if(@user.save)
      session[:user_id]=@user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if(!currently_signed_in?(@user))
      redirect_to :root
      return
    end
    @user.password_confirmation=params[:password_confirmation]
    @user.password=params[:password]
    if(@user.save)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    if(!currently_signed_in?(@user))
      redirect_to :root
    else
      @user.destroy
    end
  end
end
