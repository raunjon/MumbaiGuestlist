class Admin::GuestlistsController <ApplicationController
  before_action :get_guestlist, only: [:update, :destroy]
  before_action :require_admin_user
  def index
    @guestlists = Guestlist.paginate(page: params[:page],per_page: 20);
  end

  def new
    @guestlist = Guestlist.new
  end

  def show

  end

  def edit
    render :index
  end

  def update
    if @guestlist.update(params.permit(:status))
      flash[:notice] = "Guestlist was successfully updated"
      redirect_to admin_guestlists_path
    end
  end
  def create
    @guestlist = Guestlist.new(guestlist_params)
    @guestlist.user = current_user
      if @guestlist.save
        flash[:notice] = "Entry made successfully"
        redirect_to guestlists_path
      else
        flash[:danger] = "Error"
        render :new
      end
  end

  private
  def get_guestlist
    @guestlist = Guestlist.find(params[:id])
  end
  def guestlist_params
    params.require(:guestlist).permit(:club_id, :mobile, :couples, :entry_date)
  end
end