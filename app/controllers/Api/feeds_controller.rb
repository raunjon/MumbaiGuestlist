class Api::FeedsController < Api::BaseController
def index
  client = Brandspotter::Client.new
 # feed = Feed.find_by(:club_id => 4)
 # hashtag = feed.hashtag
  #client.create_subscription(hashtag: hashtag)
  render :json => client.subscriptions

end
end