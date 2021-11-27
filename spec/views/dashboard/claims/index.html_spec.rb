# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/claims/index.html.erb' do
  let(:user) { create(:user) }
  let(:giveaway) { create(:giveaway, user: user) }
  let(:claim) { create(:claim, user: user, giveaway: giveaway) } 
  

  before do
    assign(:user, user)
    assign(:giveaways, [giveaway])
    assign(:claims, [claim])
  end

  it 'displays the claimed giveaway card' do
    render

    expect(rendered).to include(claim.giveaway.title)
  end
end
