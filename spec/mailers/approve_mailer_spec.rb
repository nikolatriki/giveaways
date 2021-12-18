# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApproveMailer, type: :mailer do
  describe 'new_approve' do
    let(:user) { create(:user) }
    let(:giveaway) { create(:giveaway, user: user, approved_to: user.id) }
    let(:mail) { described_class.new_approve(giveaway) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Your claim is approved')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['support@giveaways.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('Congratulations!')
    end
  end
end
