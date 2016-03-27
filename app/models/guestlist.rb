class Guestlist < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  validates :user_id, presence: true
  validates :entry_date, presence: true
  validates :couples, presence: true, length: { minimum: 1, maximum: 10}
  validates :mobile, presence: true, length: { minimum: 10, maximum: 10}
  validates :club_id, presence: true

  def get_status(status)
    if status==Status::PENDING
      "Pending"
    elsif status==Status::ACCEPTED
      "Accepted"
    elsif status==Status::DECLINED
      "Declined"
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ["ID","FacebookID","Username","Entry Date", "Club", "Couples","Mobile", "Status"]
      all.each do |guestlist|
        csv << [guestlist.id,guestlist.user.uid,guestlist.user.name,guestlist.entry_date,guestlist.club.title,guestlist.couples,guestlist.mobile,guestlist.status]
      end
    end
  end


end
