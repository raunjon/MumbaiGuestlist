class Club < ActiveRecord::Base
  has_many :guestlists
  has_one :feed, dependent: :destroy
  accepts_nested_attributes_for :feed
  validates :title, presence: true, length: { minimum: 3, maximum: 50}
end
