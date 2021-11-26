require 'rails_helper'

describe Dashboard::ClaimsController, type: :controller do
  let!(:user) { create :user }

  before { sign_in user }

  describe 'GET dashboard/claims' do
    it 'has a 200 status code' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
end
