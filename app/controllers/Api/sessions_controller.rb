class Api::SessionsController < Api::BaseController
  def new

  end

  def index
    user = current_user
    if logged_in?
      if params[:includes]
        if !params[:includes].empty?
          render :json => user, :include => :guestlists,  :except =>[:password_digest]
        else
          render :json => user, :except =>[:password_digest]
        end
      else
        render :json => user, :except =>[:password_digest]
      end
    else
      render :json => {response: "Please login to continute"},:status => :unauthorized
    end
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"],2)
    request.session[:user_id] = user.id
    request.cookies[:user_id] = {
        :value => user.id,
        :expires => 1.year.from_now,
        :domain => 'http://mumbaiguestlist.com',
        :httponly => false
    }
    #render :json => request.env["omniauth.auth"]
    render :json => user, :except =>[:password_digest]
  end

  def destroy
    session[:user_id] = nil
    request.cookies.delete(:user_id)
    render :json => {:success => 'Successfully Logged out'}
  end

end