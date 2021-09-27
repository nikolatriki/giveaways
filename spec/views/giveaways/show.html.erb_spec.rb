# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'giveaways/show', type: :view do
  let!(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }

  before do
    assign(:giveaway, giveaway)
  end

  it 'displays the giveaway attributes' do
    render
    expect(rendered).to include(giveaway.title, giveaway.location)
  end

  it 'display an image of the giveaway' do
    render
    expect(rendered).to include('212-2127438_decent-giveaways-png')
  end

  context 'without logged in user' do
    it 'displays only Back and New comment' do
      render

      expect(rendered).to include('Back', 'New Comment')
    end
  end
end
