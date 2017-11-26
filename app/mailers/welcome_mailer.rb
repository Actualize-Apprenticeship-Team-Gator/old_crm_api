class WelcomeMailer < ApplicationMailer
  default from: '"Actualize Admissions" <admissions@actualize.co>'

  def welcome_email(lead)
    attachments.inline["welcome-email-image.jpg"] = File.read("#{Rails.root}/app/assets/images/welcome-email-image.jpg")
    @lead = lead
    mail(to: @lead.email, subject: 'Welcome to Actualize!')
  end
end
