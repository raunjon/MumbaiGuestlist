class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  include Status
  helper_method :current_user, :logged_in?, :is_current_user_admin?, :auth_facebook, :get_status
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def auth_facebook(auth)
    @auth_facebook = auth
  end
  def logged_in?
    !!current_user
  end

  def is_current_user_admin?
    if logged_in?
      current_user.admin
    else
      false
    end
  end
  def require_user
    if !logged_in?
      flash[:danger] = "Please login to continue";
      redirect_to "/auth/facebook"
    end
  end
  def require_admin_user
    if !logged_in? || !is_current_user_admin?
      flash[:danger] = "Please login to continue";
      redirect_to admin_login_path;
    end
  end

  def get_status(status)
    if status==Status::PENDING
      "Pending"
    elsif status==Status::ACCEPTED
      "Accepted"
    elsif status==Status::DECLINED
      "Declined"
    end
  end

end
