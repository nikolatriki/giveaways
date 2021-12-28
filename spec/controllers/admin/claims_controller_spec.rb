# frozen_string_literal: true

require 'rails_helper'

describe Admin::ClaimsController, type: :controller do # rubocop:disable Metrics/BlockLength
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:claim) { create :claim }
  let!(:user) { create :user }
  let!(:giveaway) { create :giveaway, user: user }
  let(:valid_attributes) do
    attributes_for(:claim).merge(user_id: claim.user_id, giveaway_id: claim.giveaway_id)
  end
  let(:invalid_attributes) do
    { user_id: '' }
  end

  before { sign_in create(:admin_user) }

  describe 'GET index' do
    let(:filters_sidebar) { page.find('#filters_sidebar_section') }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the claim' do
      get :index
      expect(assigns(:claims)).to include(claim)
    end

    it 'renders the expected columns' do
      get :index
      expect(page).to have_content(claim.user.name)
      expect(page).to have_content(claim.giveaway.title)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns the claim' do
      get :new
      expect(assigns(:claim)).to be_a_new(Claim)
    end

    it 'renders the form elements' do
      get :new
      expect(page).to have_field('Giveaway')
      expect(page).to have_field('User')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new claim' do
        expect do
          post :create, params: { giveaway_id: giveaway.id, claim: { user_id: user.id, giveaway_id: giveaway.id } }
        end.to change(Claim, :count).by(1)
      end

      it 'assigns a newly created claim as @claim' do
        post :create,
             params: { giveaway_id: claim.giveaway_id,
                       claim: { user_id: claim.user_id, giveaway_id: claim.giveaway_id } }
        expect(assigns(:claim)).to be_a(Claim)
      end

      it 'redirects to the created claim' do
        post :create, params: { claim: valid_attributes }
        expect(response).to have_http_status(:ok)
      end

      it 'creates the claim' do
        post :create, params: { claim: valid_attributes }
        claim = Claim.last
        expect(claim.giveaway_id).to eq(valid_attributes[:giveaway_id])
        expect(claim.user_id).to eq(valid_attributes[:user_id])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { claim: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved claim as @claim' do
        post :create, params: { claim: invalid_attributes }
        expect(assigns(:claim)).to be_a_new(Claim)
      end

      it 'invalid_attributes do not create a claim' do
        expect do
          post :create, params: { claim: invalid_attributes }
        end.not_to change(Claim, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: claim.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the claim' do
      expect(assigns(:claim)).to eq(claim)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: claim.id, user: valid_attributes }
      end

      it 'assigns the claim' do
        expect(assigns(:claim)).to eq(claim)
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_claim_path(claim))
      end

      it 'updates the claim' do
        claim.reload

        expect(claim.giveaway_id).to eq(valid_attributes[:giveaway_id])
        expect(claim.user_id).to eq(valid_attributes[:user_id])
      end
    end

    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: claim.id, claim: invalid_attributes }
        expect(response).to have_http_status(:ok)
      end

      it 'does not change claim' do
        expect do
          put :update, params: { id: claim.id, claim: invalid_attributes }
        end.not_to(change { claim.reload.id })
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: claim.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the user' do
      expect(assigns(:claim)).to eq(claim)
    end

    it 'renders the form elements' do
      expect(page).to have_content(claim.user.name)
      expect(page).to have_content(claim.giveaway.title)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: claim.id }
      end.to change(Claim, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: claim.id }
      expect(response).to redirect_to(admin_claims_path)
    end
  end
end
