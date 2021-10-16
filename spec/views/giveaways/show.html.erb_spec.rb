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

  # it 'display an image of the giveaway' do
  #   render
  #   expect(rendered).to have_css('.image')
  # end

  context 'without logged in user' do
    it 'displays only Back button' do
      render

      expect(rendered).to include('Back')
    end
  end
end
