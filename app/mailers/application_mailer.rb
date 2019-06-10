class ApplicationMailer < ActionMailer::Base
  default from: "alerts@#{ENV['MAILER_DOMAIN'] ? ENV['MAILER_DOMAIN'].split("//")[1] : ''}"
  layout 'mailer'

  def send_login_alert(ip)
    return if ENV["ALERT_EMAIL_RECIPIENT"].blank?
    mail(
      to: ENV["ALERT_EMAIL_RECIPIENT"],
      subject: "New login from #{ip} on #{Time.now.strftime('%b %e, %l:%M %p')}",
      body: "If this isn't from you, you should stop your instance and change your password."
    )
  end
end
