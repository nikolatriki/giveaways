# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET signup' do
    it 'has a success status code' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates new user' do
        expect do
          post :create,
               params: {
                 user: { name: 'Any Name', email: 'test@test.com', password: '123456',
                         password_confirmation: '123456' }
               }
        end.to change(User, :count).by(1)
      end
    end
  end
end
