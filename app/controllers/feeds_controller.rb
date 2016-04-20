class FeedsController < ApplicationController
  def index
    client = Brandspotter::Client.new
    feed = Feed.find_by(:club_id => 4)
    hashtag = feed.hashtag
    client.create_subscription(hashtag: 'clubroyalty')
    render :client
  end
end