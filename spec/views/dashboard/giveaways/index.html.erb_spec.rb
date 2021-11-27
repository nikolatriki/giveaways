# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/giveaways/index.html.erb' do
  let(:user) { create(:user) }
  let(:giveaway) { create(:giveaway, user: user) }
  let(:claim) { create(:claim, user: user, giveaway: giveaway) }

  before do
    # assign(:user, user)
    # assign(:giveaways, [giveaway])
    assign(:waiting_response_my_giveaways,
          [Claim.all.uniq(&:giveaway_id).map(&:giveaway).select do |giveaway|
              giveaway.user_id == user.id
            end])
    # assign(:not_claimed_giveaways, [giveaways - waiting_response_my_giveaways])
  end

  it 'displays a giveaway card' do
    render
    waiting_response_my_giveaways.each do |giveaway|
      expect(rendered).to include(giveaway.title.truncate(20))
    end
  end
end
