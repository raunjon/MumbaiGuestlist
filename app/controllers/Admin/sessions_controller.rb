class Admin::SessionsController <ApplicationController

  def new
    if logged_in? && is_current_user_admin?
      redirect_to admin_clubs_path
    end
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.admin
        redirect_to admin_clubs_path
      else
        redirect_to root_path
      end
      session[:user_id] = user.id
    else
      render 'new'
      flash.now[:danger] = "There was something wrong with your login information"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_login_path
  end

end