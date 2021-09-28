# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }
  let!(:comment) { create(:comment, giveaway: giveaway, user: user) }

  describe 'GET new' do
    it 'has a success status code' do
      get :new, params: { giveaway_id: giveaway.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates new comment' do
        expect do
          post :create,
               params: { giveaway_id: giveaway.id,
                         comment: { body: 'Sentence is here.' } }
        end.to change(Comment, :count).by(1)
      end
    end
  end

  describe 'GET edit' do
    it 'has a success status code' do
      get :edit, params: { giveaway_id: giveaway.id, id: comment.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PATCH update' do
    context 'with valid attributes' do
      it 'edits the comment' do
        patch :update, params: { giveaway_id: giveaway.id, id: comment.id,
                                 comment: { body: comment.body } }
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the comment' do
      expect do
        delete :destroy, params: { giveaway_id: giveaway.id, id: comment.id }
      end.to change(Comment, :count).by(-1)
    end
  end
end
