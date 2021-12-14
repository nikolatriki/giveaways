require "rails_helper"

RSpec.describe ClaimMailer, type: :mailer do
  describe "new_claim" do
    let(:mail) { ClaimMailer.new_claim }

    it "renders the headers" do
      expect(mail.subject).to eq("New claim")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
