# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/giveaways/index.html.erb' do
  let(:user) { create(:user) }
  let(:giveaway) { create(:giveaway, user: user) }
  let(:claim) { create(:claim, user: user, giveaway: giveaway) } 
  

  before do
    assign(:user, user)
    assign(:giveaways, [giveaway])
  end

  it 'displays a giveaway card' do
    render

    expect(rendered).to include(giveaway.title)
  end
end
