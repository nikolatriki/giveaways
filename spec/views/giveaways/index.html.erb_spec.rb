# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'giveaways/index', type: :view do
  let!(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }

  before do
    assign(:giveaways, [giveaway])
    assign(:pagy, Pagy.new(count: 103, page: 1))
  end

  context 'with giveaway attributes' do
    let(:giveaways) { [giveaway] }

    it 'displays the giveaway title' do
      render
      giveaways.each do |giveaway|
        expect(rendered).to include(giveaway.title.truncate(15))
      end
    end

    it 'displays the giveaway location' do
      render
      giveaways.each do |giveaway|
        expect(rendered).to include(giveaway.location)
      end
    end

    it 'display an image of the giveaway' do
      render
      expect(rendered).to include('https://bulma.io/images/placeholders/128x128.png')
    end
  end

  it 'displays the pagination buttons' do
    render
    expect(rendered).to include('Next')
  end
end
