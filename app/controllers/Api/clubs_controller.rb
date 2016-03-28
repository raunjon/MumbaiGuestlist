class Api::ClubsController < Api::BaseController
  before_action :set_club, only: [:show]
  def index
    @clubs = Club.all

    respond_to do |format|
        if request.format.symbol == :json
          format.json do
           # response['X-Message-1'] = request.content_type
            render json: @clubs.to_json
          end
        elsif request.format.symbol == :xml
          format.xml { render :xml => @clubs }
        end

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