# Preview all emails at http://localhost:3000/rails/mailers/claim_mailer
class ClaimMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/claim_mailer/new_claim
  def new_claim
    claim = Claim.last
    ClaimMailer.new_claim(claim)
  end
end
