class ApproveMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.approve_mailer.new_approve.subject
  #
  def new_approve(giveaway)
    @giveaway = giveaway
    @user = User.find_by(id: @giveaway.approved_to)

    mail to: @user.email,
         subject: 'Your claim is approved'
  end
end
