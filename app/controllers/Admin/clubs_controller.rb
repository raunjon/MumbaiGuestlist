class Admin::ClubsController < ApplicationController
  before_action :set_club, only: [:edit, :update, :show, :destroy]
  before_action :require_admin_user
  def index
    @clubs = Club.all
    respond_to do |format|
      format.html
      format.json { render json: @clubs }
    end
  end

  def new
    @club = Club.new
    @club.build_feed
  end

  def create
    @club = Club.new(club_params)
    if @club.save
      flash[:notice] = "Club was successfully created"
      redirect_to admin_clubs_path
    else
      render :new
    end
  end

  def edit

  end

  def show
    respond_to do |format|
      format.html
      glists = @club.guestlists
      format.json { render json: GuestlistsDatatable.new(view_context,glists) }
      format.xls {render :xls => glists}
    end
  end

  def update
   # render :json => club_params

    if @club.update(club_params)
      flash[:notice] = "Club was successfully updated"
      redirect_to admin_clubs_path
      #render :json => club_params
    end
  end

  def destroy
      @club.destroy
      redirect_to admin_clubs_path
  end

  private
  def set_club
    @club = Club.find(params[:id])
  end
  def club_params
    params.require(:club).permit!
  end
end