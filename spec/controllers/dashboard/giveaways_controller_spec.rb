require 'rails_helper'

describe Dashboard::GiveawaysController, type: :controller do
  let!(:user) { create :user }

  before { sign_in user }

  describe 'GET dashboard/giveaways' do
    it 'has a 200 status code' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET dashboard/giveaways/:id' do
    let(:giveaway) { create(:giveaway, user: user) }

    it 'has a 200 status code' do
      get :show, params: { id: giveaway.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET dashboard/giveaways/new' do
    it 'has a 200 status code' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create giveaway' do
    context 'with valid attributes' do
      it 'creates new giveaway' do
        expect do
          post :create,
                params: { giveaway: { title: 'Some title', description: 'Some text', location: 'Some location' } }
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

  describe 'GET dashboard/giveaways/:id/edit' do
    let(:giveaway) { create(:giveaway, user: user) }

    it 'has a 200 status code' do
      get :edit, params: { id: giveaway.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH post' do
    let(:giveaway) { create(:giveaway, user: user) }

    context 'with valid attributes' do
      it 'updates giveaway' do
        patch :update,
              params: { id: giveaway.id, giveaway: { title: 'Some title', description: 'Some text', location: 'Some location' } }
        allow(giveaway).to receive(:title).and_return('Some title')
        allow(giveaway).to receive(:description).and_return('Some text')
        allow(giveaway).to receive(:location).and_return('Some location')
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
    let!(:giveaway) { create(:giveaway, user: user) }

    it 'deletes a giveaway' do
      expect do
        delete :destroy, params: { id: giveaway.id }
      end.to change(Giveaway, :count).by(-1)
    end
  end
end
