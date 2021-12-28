# frozen_string_literal: true

require 'rails_helper'

describe Admin::GiveawaysController, type: :controller do # rubocop:disable Metrics/BlockLength
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:new_giveaway) { create :giveaway }
  let(:admin_user) { create :admin_user }
  let(:valid_attributes) do
    attributes_for(:giveaway).merge(user_id: new_giveaway.user_id, title: new_giveaway.title,
                                    description: new_giveaway.description, location: new_giveaway.location)
  end
  let(:invalid_attributes) { { user_id: '' } }

  before { sign_in admin_user }

  describe 'GET index' do # rubocop:disable RSpec/MultipleMemoizedHelpers
    let(:filters_sidebar) { page.find('#filters_sidebar_section') }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the giveaway' do
      get :index
      expect(assigns(:giveaways)).to include(new_giveaway)
    end

    it 'renders the expected columns' do
      get :index
      expect(page).to have_content('Title')
      expect(page).to have_content('Description')
      expect(page).to have_content('Location')
    end

    it 'filter Title exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_title"]')
      expect(filters_sidebar).to have_css('input[name="q[location_contains]"]')
    end

    it 'filter Name works' do
      matching_post = create :giveaway, title: 'ABCDEF'
      non_matching_post = create :giveaway, title: 'GHRTY'

      get :index, params: { q: { title_or_location_cont: 'BCDE' } }

      expect(assigns(:giveaways)).to include(matching_post)
      expect(assigns(:giveaways)).not_to include(non_matching_post)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns the giveaway' do
      get :new
      expect(assigns(:giveaway)).to be_a_new(Giveaway)
    end

    it 'renders the form elements' do
      get :new
      expect(page).to have_field('Title')
      expect(page).to have_field('Description')
      expect(page).to have_field('Location')
      expect(page).to have_field('User')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new Giveaway' do
        expect do
          post :create, params: { giveaway: valid_attributes }
        end.to change(Giveaway, :count).by(1)
      end

      it 'assigns a newly created giveaway as @giveaway' do
        post :create, params: { giveaway: valid_attributes }
        expect(assigns(:giveaway)).to be_a(Giveaway)
        expect(assigns(:giveaway)).to be_persisted
      end

      it 'redirects to the created giveaway' do
        post :create, params: { giveaway: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_giveaway_path(Giveaway.last))
      end

      it 'creates the giveaway' do
        post :create, params: { giveaway: valid_attributes }
        last_giveaway = Giveaway.last

        expect(last_giveaway.title).to eq(valid_attributes[:title])
        expect(last_giveaway.description).to eq(valid_attributes[:description])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { giveaway: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved giveaway as @giveaway' do
        post :create, params: { giveaway: invalid_attributes }
        expect(assigns(:giveaway)).to be_a_new(Giveaway)
      end

      it 'invalid_attributes do not create a giveaway' do
        expect do
          post :create, params: { giveaway: invalid_attributes }
        end.not_to change(Giveaway, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: new_giveaway }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the giveaway' do
      expect(assigns(:giveaway)).to eq(new_giveaway)
    end

    it 'renders the form elements' do
      expect(page).to have_field('User', with: new_giveaway.user.id)
      expect(page).to have_field('Title', with: new_giveaway.title)
      expect(page).to have_field('Location', with: new_giveaway.location)
      expect(page).to have_field('Description', with: new_giveaway.description)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: new_giveaway.id, giveaway: valid_attributes }
      end

      it 'assigns the giveaway' do
        expect(assigns(:giveaway)).to eq(new_giveaway)
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_giveaway_path(new_giveaway))
      end

      it 'updates the giveaway' do
        expect(new_giveaway.reload.user_id).to eq(valid_attributes[:user_id])
        expect(new_giveaway.title).to eq(valid_attributes[:title])
        expect(new_giveaway.description).to eq(valid_attributes[:description])
      end
    end

    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: new_giveaway.id, giveaway: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'does not change post' do
        expect do
          put :update, params: { id: new_giveaway.id, giveaway: invalid_attributes }
        end.not_to(change { new_giveaway.reload.title })
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: new_giveaway.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the post' do
      expect(assigns(:giveaway)).to eq(new_giveaway)
    end

    it 'renders the form elements' do
      expect(page).to have_content(new_giveaway.title)
      expect(page).to have_content(new_giveaway.description)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: new_giveaway.id }
      end.to change(Giveaway, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: new_giveaway.id }
      expect(response).to redirect_to(admin_giveaways_path)
    end
  end
end
