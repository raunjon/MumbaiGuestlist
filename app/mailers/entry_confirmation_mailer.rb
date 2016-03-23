class EntryConfirmationMailer < ActionMailer::Base
  default from: "jonejaraunak99@gmail.com"\

  def send_email(user)
    @guestlist = user
    mail(to: @guestlist.user.email, subject: 'Entry Made')
  end
end