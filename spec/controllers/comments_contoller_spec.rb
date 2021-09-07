# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:giveaway) { create(:giveaway) }
  let(:comment) { create(:comment, giveaway: giveaway) }

  describe 'GET new' do
    it 'has a success status code' do
      get :new, params: { giveaway_id: 1 }
      expect(response).to have_http_status(:success)
    end
  end

  # describe 'POST create' do
  #   context 'with valid attributes' do
  #     it 'creates new comment' do

  #         post :create

  #       expect(response).to include(comment)
  #     end
  #   end
  # end
end
