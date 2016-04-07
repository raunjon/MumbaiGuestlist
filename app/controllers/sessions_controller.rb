class SessionsController <ApplicationController

  def new
    if logged_in?
      #redirect_to clubs_path
    end
  end

  def index
    if logged_in?
      render :json => current_user
    else
      render :json => {error: request.cookies[:user_id]}
    end
  end

  def create
    source = 0
    if mobile?
      source = 1
    end
    user = User.from_omniauth(request.env["omniauth.auth"],source)
    session[:user_id] = user.id
    if user.admin==true
      redirect_to admin_clubs_path
    else
      redirect_to guestlists_path
    end

    #render :json => user
   end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end