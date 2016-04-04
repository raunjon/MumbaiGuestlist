class Admin::UsersController <ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_admin_user

  def index
    @users = User.paginate(page: params[:page],per_page: 20);
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "User was successfully created"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit

  end

  def show
    #users = User.includes(:guestlists);
    respond_to do |format|
      format.html
      glists = @user.guestlists
      format.json { render json: GuestlistsDatatable.new(view_context,glists) }
      # if params[:includes]
      #   format.json {render :json => users,  :include => params[:includes] }
      # else
      #format.json {render :json => users}
      #format.xml {render :xml => users}
      #end
    end
  end
  def destroy
    @user.destroy
    redirect_to admin_users_path
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to admin_users_path
    else
      flash[:notice] = "User was not successfully updated"
      redirect_to admin_users_path
    end
  end
  private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :admin, :autoaccept, :mobile, :provider, :gender)
  end
end