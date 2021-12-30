# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PicturesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }
  let!(:picture) { create(:picture, giveaway: giveaway) }

  before do
    user.confirm
    sign_in user
  end

  describe 'DELETE destroy' do
    it 'deletes the picture' do
      expect do
        delete :destroy, params: { giveaway_id: giveaway.id, id: picture.id }
      end.to change(Picture, :count).by(-1)
    end
  end
end
