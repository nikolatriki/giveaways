# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/giveaways/index.html.erb' do
  let(:user) { create(:user) }
  let(:giveaway) { create(:giveaway, user: user) }
  let(:claim) { create(:claim, user: user, giveaway: giveaway) }
  let(:given_giveaway) { create(:giveaway, user: user, approved_to: 'John Doe') }
  let(:waiting_response_my_giveaway) { create(:giveaway, user: user) }

  before do
    sign_in user
    assign(:giveaways, [giveaway])
    assign(:waiting_response_my_giveaways, [waiting_response_my_giveaway])
    assign(:given_giveaways, [given_giveaway])
    # check formula for not_claimed_giveaways
    assign(:not_claimed_giveaways, [])
  end

  it 'displays a giveaway card' do
    render

    expect(rendered).to include(waiting_response_my_giveaway.title.truncate(20))
  end
end