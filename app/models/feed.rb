class Feed < ActiveRecord::Base
  belongs_to :club
  #validates :club_id, presence: true
end