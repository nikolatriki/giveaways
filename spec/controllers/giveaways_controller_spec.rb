# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GiveawaysController, type: :controller do
  let(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }

  before do
    user.confirm
    sign_in user
  end

  describe 'GET giveaways' do
    it 'has a 200 status code' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET giveaways/:id' do
    it 'has a 200 status code' do
      get :show, params: { id: giveaway.id }
      expect(response).to have_http_status(:success)
    end
  end
end
