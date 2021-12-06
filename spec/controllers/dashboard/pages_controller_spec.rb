# frozen_string_literal: true

require 'rails_helper'

describe Dashboard::PagesController, type: :controller do
  let!(:user) { create :user }

  before { sign_in user }

  describe 'GET dashboard-home' do
    it 'has a 200 status code' do
      get :home
      expect(response).to have_http_status(:success)
    end
  end
end
