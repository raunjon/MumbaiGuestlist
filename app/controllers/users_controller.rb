class UsersController <ApplicationController
  before_action :require_user
  def index
    @users = User.paginate(page: params[:page],per_page: 20);
  end
end