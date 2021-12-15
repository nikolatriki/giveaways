# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClaimMailer, type: :mailer do
  describe 'new_claim' do
    let!(:user) { create(:user) }
    let!(:giveaway) { create(:giveaway, user: user) }
    let(:claim) { create(:claim, giveaway: giveaway) }
    let(:mail) { described_class.new_claim(claim) }

    it 'renders the headers' do
      expect(mail.subject).to eq("New claim for #{giveaway.title}")
      expect(mail.to).to eq([giveaway.user.email.to_s])
      expect(mail.from).to eq(['support@giveaways.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('A new claim')
    end
  end
end
