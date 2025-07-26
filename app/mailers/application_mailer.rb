# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # Option 1: Use MailerSend sandbox domain (replace trial-xxx with your actual domain)
  # Option 2: Use your personal email that's verified with MailerSend
  default from: 'MS_YuRovs@test-eqvygm0ok6wl0p7w.mlsender.net'
  layout 'mailer'
end
