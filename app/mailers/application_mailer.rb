# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'support@giveaways.com'
  layout 'mailer'
end
