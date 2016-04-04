class Admin::GuestlistsController <ApplicationController
  before_action :get_guestlist, only: [:update, :destroy]
  before_action :require_admin_user
  def index
   # @guestlists = Guestlist.paginate(page: params[:page],per_page: 20);
    respond_to do |format|
      format.html
      if params[:status]
        if !params[:status].empty?
           glist_status = params[:status]
           glists = Guestlist.where(status: glist_status)
        else
          glists = Guestlist.all
        end
    elsif params[:date]
      if !params[:date].empty?
        glist_date = params[:date]
        glists = Guestlist.where(entry_date: glist_date)
      else
        glists = Guestlist.all
      end
        else
        glists = Guestlist.all
      end
      format.json { render json: GuestlistsDatatable.new(view_context,glists) }
      glists.includes(:user)
      @guestlists = glists;
      format.xls {render :xls => glists, :includes => :club}
      #format.csv { send_data @glists.to_csv }
      #format.xls { }

    end
  end

  def new
    @guestlist = Guestlist.new
  end

  def show
    redirect_to admin_guestlists_path
  end

  def edit
    Guestlist.all.each do |g|
      if g.user.autoaccept==true && g.entry_date > Date.today && g.status==0
        g.update_attribute(:status, 1)
      end
    end
    redirect_to admin_guestlists_path
  end

  def update
    if !params.permit(:status).nil?
    if @guestlist.update(params.permit(:status))
      flash[:notice] = "Guestlist was successfully updated"
      if params[:status]==Status::ACCEPTED
        @guestlist.user.autoaccept = true
       if @guestlist.user.update_attribute(:autoaccept,true)
        flash[:notice] = "User was successfully updated"
      else
        flash[:notice] = "User was not successfully updated"
         end
      end
      Sms.send_sms(@guestlist)
     redirect_to admin_guestlists_path

    else
      redirect_to admin_clubs_path
    end
    elsif !params['autoaccept'].nil?
      Guestlist.where(user.autoaccept => true).update_all(:status=>1)
      redirect_to admin_clubs_path
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