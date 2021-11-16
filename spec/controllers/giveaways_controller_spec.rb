# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GiveawaysController, type: :controller do
  let(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }

  before { sign_in user }

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

  describe 'GET new' do
    it 'has a success status code' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates new giveaway' do
        expect do
          post :create,
               params: { user_id: user.id,
                         giveaway: { title: 'title giveaway', description: 'description', location: 'Somewhere',
                                     pictures_attributes: [title: 'title piture'] } }
        end.to change(Giveaway, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'doesnt create new giveaway' do
        expect do
          post :create,
               params: { giveaway: { title: '', description: '' } }
        end.to change(Giveaway, :count).by(0)
      end
    end
  end

  describe 'GET giveaways/:id/edit' do
    it 'has a 200 status code' do
      get :edit, params: { id: giveaway.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH update' do
    context 'with valid attributes' do
      it 'updates the giveaway' do
        patch :update,
              params: { id: giveaway.id, giveaway: { title: 'Some title', description: 'Some text' } }
        allow(giveaway).to receive(:title).and_return('Some title')
        allow(giveaway).to receive(:description).and_return('Some text')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the giveaway' do
        patch :update,
              params: { id: giveaway.id, giveaway: { title: '', description: '' } }
        expect(response).not_to be_redirect
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the giveaway' do
      expect do
        delete :destroy, params: { id: giveaway.id }
      end.to change(Giveaway, :count).by(-1)
    end
  end
end
