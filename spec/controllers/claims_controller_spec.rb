# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClaimsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }
  let(:claim) { create(:claim, giveaway: giveaway) }

  before { sign_in user }

  describe 'POST create' do
    it 'creates new claim' do
      expect do
        post :create, params: { giveaway_id: giveaway.id, claim: { user_id: user.id, giveaway_id: giveaway.id } }
      end.to change(Claim, :count).by(1)
    end
  end
end
