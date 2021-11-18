# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  let!(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }
  let!(:claim) { create(:claim, giveaway: giveaway, user: user) }

  before do
    assign(:user, user)
    assign(:giveaway, giveaway)
    assign(:claim, claim)
  end

  context 'without logged in user' do
    it 'displays user name' do
      render

      expect(rendered).to include(user.name.capitalize)
    end

    it 'displays the giveaways created by user' do
      render

      user.giveaways.each do |giveaway|
        expect(rendered).to include(giveaway.title)
      end
    end

    it 'displays the claims created by user' do
      render

      user.claims.each do |claim|
        expect(rendered).to include(claim.giveaway.title)
      end
    end
  end

  context 'with logged in user' do
    before { sign_in user }

    it 'displays edit user link' do
      render

      expect(rendered).to include(t('users.show.edit_user'))
    end
  end
end
