class Club < ActiveRecord::Base
  has_many :guestlists
  validates :title, presence: true, length: { minimum: 3, maximum: 50}
end
