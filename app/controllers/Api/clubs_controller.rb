class Api::ClubsController < Api::BaseController
  before_action :set_club, only: [:show]
  def index
    @clubs = Club.first
    render json: @clubs.to_json
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