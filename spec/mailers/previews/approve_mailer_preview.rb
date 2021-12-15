# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/approve_mailer
class ApproveMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/approve_mailer/new_approve
  def new_approve
    giveaway = Giveaway.find_by(approved_to: !nil)
    ApproveMailer.new_approve(giveaway)
  end
end
