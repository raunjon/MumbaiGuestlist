require 'date'
class Api::GuestlistsController < Api::BaseController
  before_action :set_guestlist, only: [:show]
  before_action 'require_user', only: [:create]
  def index
  #  @guestlist = Guestlist.new
    @guestlists = Guestlist.where(user: current_user)
    @guestlists.joins(:clubs)
    render :json => @guestlists, :include => (:club)
  end

  def new
    
  end

  def show
    # if @guestlist.user != current_user
    #   redirect_to(guestlists_path)
    # end
  end

  def create
    @guestlist = Guestlist.new(guestlist_params)
    dateString = @guestlist.entry_date.to_s
    date = Date.parse(dateString)
    @guestlist.entry_date = date.strftime('%Y-%m-%d')
    @guestlist.user = current_user
      if @guestlist.save
        @guestlist.user.update_attribute(:mobile, @guestlist.mobile)
        render :json => @guestlist
      else
        render :json => {response: "Please login to continute"},:status => :unauthorized
      end
  end


  private
  def guestlist_params
    params.permit(:club_id, :mobile, :couples, :entry_date)
  end
  def set_guestlist
    @guestlist = Guestlist.find(params[:id])
  end
end