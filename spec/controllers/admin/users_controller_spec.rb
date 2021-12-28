# frozen_string_literal: true

require 'rails_helper'

describe Admin::UsersController, type: :controller do # rubocop:disable Metrics/BlockLength
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:user) { create :user }
  let(:valid_attributes) do
    attributes_for(:user)
  end
  let(:invalid_attributes) do
    { name: '' }
  end

  before { sign_in create(:admin_user) }

  describe 'GET index' do
    let(:filters_sidebar) { page.find('#filters_sidebar_section') }

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns the user' do
      get :index
      expect(assigns(:users)).to include(user)
    end

    it 'renders the expected columns' do
      get :index
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.email)
    end

    it 'filter Name exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_name"]', text: 'Name')
      expect(filters_sidebar).to have_css('input[name="q[name_contains]"]')
    end

    it 'filter Name works' do
      matching_user = create :user, name: 'ABCDEFG'
      non_matching_user = create :user, name: 'HIJKLMN'

      get :index, params: { q: { name_cont: 'BCDEF' } }

      expect(assigns(:users)).to include(matching_user)
      expect(assigns(:users)).not_to include(non_matching_user)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns the user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'renders the form elements' do
      get :new
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect do
          post :create, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, params: { user: valid_attributes }
        expect(assigns(:user)).to be_a(User)
      end

      it 'redirects to the created user' do
        post :create, params: { user: valid_attributes }
        expect(response).to have_http_status(:found)
      end

      it 'creates the user' do
        post :create, params: { user: valid_attributes }
        user = User.last

        expect(user.name).to eq(valid_attributes[:name])
        expect(user.email).to eq(valid_attributes[:email])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved user as @user' do
        post :create, params: { user: invalid_attributes }
        expect(assigns(:user)).to be_a_new(User)
      end

      it 'invalid_attributes do not create a user' do
        expect do
          post :create, params: { user: invalid_attributes }
        end.not_to change(User, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: user.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the form elements' do
      expect(page).to have_field('Name', with: user.name)
      expect(page).to have_field('Email', with: user.email)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: user.id, user: valid_attributes }
      end

      it 'assigns the user' do
        expect(assigns(:user)).to eq(user)
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_user_path(user))
      end

      it 'updates the user' do
        user.reload

        expect(user.name).to eq(valid_attributes[:name])
        expect(user.email).to eq(valid_attributes[:email])
      end
    end

    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: user.id, user: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'does not change user' do
        expect do
          put :update, params: { id: user.id, user: invalid_attributes }
        end.not_to(change { user.reload.name })
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: user.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the user' do
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the form elements' do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.email)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(admin_users_path)
    end
  end
end
