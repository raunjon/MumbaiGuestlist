class Guestlist < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  validates :user_id, presence: true
  validates :entry_date, presence: true
  validates :couples, presence: true, length: { minimum: 1, maximum: 10}
  validates :mobile, presence: true, length: { minimum: 10, maximum: 10}
  validates :club_id, presence: true

end
