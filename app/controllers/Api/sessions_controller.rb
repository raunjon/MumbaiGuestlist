class Api::SessionsController < Api::BaseController
  def new

  end

  def index
    user = current_user
    user
    if logged_in?
      render :json => user, :except =>[:password_digest]
    else
      render :json => {response: "Please login to continute"},:status => :unauthorized
    end
  end

  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    request.session[:user_id] = user.id
    request.cookies[:user_id] = {
        :value => user.id,
        :expires => 1.year.from_now,
        :domain => 'http://localhost:3000',
        :httponly => false
    }
    render :json => user, :except =>[:password_digest]
  end

  def destroy
    session[:user_id] = nil
    request.cookies.delete(:user_id)
    render :json => {:success => 'Successfully Logged out'}
  end

end