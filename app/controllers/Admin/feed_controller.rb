class Admin::FeedController < ApplicationController
  before_action :require_admin_user

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)
    if @feed.save
      flash[:notice] = "Feed was successfully created"
      redirect_to admin_clubs_path
    else
      render :new
    end
  end

  private
  def set_club
    @feed = Feed.find(params[:id])
  end
  def feed_params
    params.require(:feed).permit!
  end
end