# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/pages/home.html.erb', type: :view do
  let!(:user) { create :user }
  let!(:giveaway) { create(:giveaway, user: user) }
  let!(:claim) { create(:claim) }

  before { sign_in user }

  it 'renders dashboard home' do
    assign(:user, user)
    assign(:given_giveaways, [giveaway])
    assign(:claims, [claim])

    render
    expect(rendered).to include('Statistics', 'Panels')
  end
end
