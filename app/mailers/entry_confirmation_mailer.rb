class EntryConfirmationMailer < ActionMailer::Base
  default from: "postmaster@sandbox0b89e4bc8e69432797897d8a0b809b89.mailgun.org"

  def send_email(user)
    @guestlist = user
    mail(to: @guestlist.user.email, subject: 'Entry Made')
  end
end