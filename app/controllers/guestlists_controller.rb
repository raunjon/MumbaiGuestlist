class GuestlistsController <ApplicationController
before_action 'require_user', only: [:create]
  def index
    @guestlist = Guestlist.new
  end

  def new
    @guestlist = Guestlist.new
  end

  def show
    render :new
  end

  def create
    @guestlist = Guestlist.new(guestlist_params)

    @guestlist.user = current_user
      if @guestlist.save
        flash[:notice] = "Entry made successfully"
        redirect_to guestlists_path
      else
        render :new
      end
  end

  private
  def guestlist_params
    params.require(:guestlist).permit(:club_id, :mobile, :couples, :entry_date)
  end
end