# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  let!(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }

  before do
    assign(:user, user)
    assign(:giveaway, giveaway)
  end

  it 'displays user name' do
    render

    expect(rendered).to include(user.name.capitalize)
  end

  it 'displays users email address' do
    render

    expect(rendered).to include(user.email)
  end

  it 'displays the giveaways created by user' do
    render

    user.giveaways.each do |giveaway|
      expect(rendered).to include(giveaway.title)
    end
  end
end
