class ClaimMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.claim_mailer.new_claim.subject
  #
  def new_claim(claim)
    @claim = claim
    @giveaway = @claim.giveaway

    mail to: @giveaway.user.email,
          subject: "New claim for #{@giveaway.title}"
  end
end
