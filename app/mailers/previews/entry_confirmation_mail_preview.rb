class EntryConfirmationMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    EntryConfirmationMailer.sample_email(User.last)
  end
end