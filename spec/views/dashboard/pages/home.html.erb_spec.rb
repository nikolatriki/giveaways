# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/pages/home.html.erb', type: :view do
  let!(:user) { create :user }
  let!(:giveaway) { create(:giveaway, user: user) }
  let!(:claim) { create(:claim, giveaway: giveaway, user: user) }
  let(:given_giveaways) { [giveaway] }
  let(:claims) { [claim] }

  before { sign_in user }

  it 'renders dashboard home' do
    assign(:user, user)
    assign(:given_giveaways, given_giveaways)
    assign(:claims, [claim])

    render
    expect(rendered).to include('Giveaways Given', given_giveaways.count.to_s)
    expect(rendered).to include('My Giveaways', user.giveaways.count.to_s)
    expect(rendered).to include('My Claims', user.claims.count.to_s)
  end
end
