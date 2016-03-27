class ClubsController < ApplicationController
  before_action :set_club, only: [:show]
  def index
    @clubs = Club.all
    respond_to do |format|
      format.html
      format.json { render json: @clubs }
    end
  end

  def show

  end

  private
  def set_club
    @club = Club.find(params[:id])
  end
  def club_params
    params.require(:club).permit(:title)
  end
end