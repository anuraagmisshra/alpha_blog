# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # Simple format that usually works with MailerSend test accounts
  default from: ENV['FROM_EMAIL'] || 'anurag1998mishra@gmail.com'
  layout 'mailer'
end
