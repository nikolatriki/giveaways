# frozen_string_literal: true

require 'rails_helper'

describe Admin::ContactsController, type: :controller do # rubocop:disable Metrics/BlockLength
  # this lets us inspect the rendered results
  render_views

  let(:page) { Capybara::Node::Simple.new(response.body) }
  let!(:contact) { create :contact }
  let(:valid_attributes) do
    attributes_for(:contact).merge(name: contact.name, message: contact.message, email: contact.email)
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

    it 'assigns the contact' do
      get :index
      expect(assigns(:contacts)).to include(contact)
    end

    it 'renders the expected columns' do
      get :index
      expect(page).to have_content(contact.name)
      expect(page).to have_content(contact.email)
      expect(page).to have_content(contact.message)
    end

    it 'filter Name exists' do
      get :index
      expect(filters_sidebar).to have_css('label[for="q_name"]')
      expect(filters_sidebar).to have_css('input[name="q[name_contains]"]')
    end

    it 'filter Name works' do
      matching_contact = create :contact, name: 'ABCDEFG'
      non_matching_contact = create :contact, name: 'HIJKLMN'

      get :index, params: { q: { name_or_email_cont: 'BCDEF' } }

      expect(assigns(:contacts)).to include(matching_contact)
      expect(assigns(:contacts)).not_to include(non_matching_contact)
    end
  end

  describe 'GET new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns the contact' do
      get :new
      expect(assigns(:contact)).to be_a_new(Contact)
    end

    it 'renders the form elements' do
      get :new
      expect(page).to have_field('Name')
      expect(page).to have_field('Email')
      expect(page).to have_field('Message')
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new contact' do
        expect do
          post :create, params: { contact: valid_attributes }
        end.to change(Contact, :count).by(1)
      end

      it 'assigns a newly created contact as @contact' do
        post :create, params: { contact: valid_attributes }
        expect(assigns(:contact)).to be_a(Contact)
        expect(assigns(:contact)).to be_persisted
      end

      it 'redirects to the created contact' do
        post :create, params: { contact: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to(redirect_to(admin_contact_path(Contact.last)))
      end

      it 'creates the contact' do
        post :create, params: { contact: valid_attributes }
        contact = Contact.last
        expect(contact.name).to eq(valid_attributes[:name])
        expect(contact.message).to eq(valid_attributes[:message])
        expect(contact.email).to eq(valid_attributes[:email])
      end
    end

    context 'with invalid params' do
      it 'invalid_attributes return http success' do
        post :create, params: { contact: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'assigns a newly created but unsaved user as @user' do
        post :create, params: { contact: invalid_attributes }
        expect(assigns(:contact)).to be_a_new(Contact)
      end

      it 'invalid_attributes do not create a user' do
        expect do
          post :create, params: { contact: invalid_attributes }
        end.not_to change(Contact, :count)
      end
    end
  end

  describe 'GET edit' do
    before do
      get :edit, params: { id: contact.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the contact' do
      expect(assigns(:contact)).to eq(contact)
    end

    it 'renders the form elements' do
      expect(page).to have_field('Name', with: contact.name)
      expect(page).to have_field('Message', with: contact.message)
      expect(page).to have_field('Email', with: contact.email)
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      before do
        put :update, params: { id: contact.id, user: valid_attributes }
      end

      it 'assigns the contact' do
        expect(assigns(:contact)).to eq(contact)
      end

      it 'returns http redirect' do
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_contact_path(contact))
      end

      it 'updates the contact' do
        contact.reload

        expect(contact.name).to eq(valid_attributes[:name])
        expect(contact.message).to eq(valid_attributes[:message])
        expect(contact.email).to eq(valid_attributes[:email])
      end
    end

    context 'with invalid params' do
      it 'returns http success' do
        put :update, params: { id: contact.id, contact: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it 'does not change contact' do
        expect do
          put :update, params: { id: contact.id, contact: invalid_attributes }
        end.not_to(change { contact.reload.name })
      end
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: contact.id }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assigns the user' do
      expect(assigns(:contact)).to eq(contact)
    end

    it 'renders the form elements' do
      expect(page).to have_content(contact.name)
      expect(page).to have_content(contact.message)
      expect(page).to have_content(contact.email)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested select_option' do
      expect do
        delete :destroy, params: { id: contact.id }
      end.to change(Contact, :count).by(-1)
    end

    it 'redirects to the field' do
      delete :destroy, params: { id: contact.id }
      expect(response).to redirect_to(admin_contacts_path)
    end
  end
end
