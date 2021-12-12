# frozen_string_literal: true

require 'rails_helper'

describe ContactsController, type: :controller do
  describe 'GET new' do
    it 'has a 200 status code' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates new contact' do
        expect do
          post :create,
               params: { contact: { name: 'Any Name', email: 'johndoe@test.com',
                                    message: 'Sentence is here.' } }
        end.to change(Contact, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'doesnt create new contact' do
        expect do
          post :create,
               params: { contact: { name: '', email: '', message: '' } }
        end.to change(Contact, :count).by(0)
      end
    end
  end
end
