# frozen_string_literal: true

# # frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET show' do
    it 'has a success status code' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end
end
