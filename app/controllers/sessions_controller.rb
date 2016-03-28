class SessionsController <ApplicationController

  def new
    if logged_in?
      #redirect_to clubs_path
    end
  end

  def index
  #  session[:user_id] = cookies[:user_id]
    if logged_in?
      render :json => current_user
    else
      render :json => {error: request.cookies[:user_id]}
    end
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to guestlists_path
    #render :json => user
   end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end