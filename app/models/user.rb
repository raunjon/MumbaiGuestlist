class User < ActiveRecord::Base
  has_many :guestlists
  validates :username, presence: true, length: { minimum: 3, maximum: 50}
  validates :email, presence: true, length: { minimum: 3, maximum: 50}
  validates :password, presence: true, length: { minimum: 3, maximum: 50}
  has_secure_password

  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.name = auth.info.name
  #     user.oauth_token = auth.credentials.token
  #     user.oauth_expires_at = Time.at(auth.credentials.expires_at)
  #     user.save!
  #   end
  # end
  def self.from_omniauth(auth,source)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = "fbid"+auth.uid
      dev_source = source
      user.email = auth.info.email
      user.gender = auth.extra.raw_info.gender
      user.birthday = auth.extra.raw_info.birthday
      user.relationship_status = auth.extra.raw_info.relationship_status
      user.source = dev_source
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      user.push_id = user.username
      user.password = "facebook-provided-password"
      user.save!
    end
  end
end
