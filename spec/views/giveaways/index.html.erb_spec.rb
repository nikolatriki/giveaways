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
        expect(rendered).to include(giveaway.title.truncate(20))
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
      giveaways.each do |giveaway|
        expect(rendered).to include(giveaway.pictures.first.to_s)
      end
    end
  end

  it 'displays the pagination buttons' do
    render
    expect(rendered).to include('Next')
  end

  it 'displays Search form' do
    render
    expect(rendered).to include(t('helpers.placeholder.search.giveaway'))
  end

  context 'with logged in user' do
    before do
      user.confirm
      sign_in user
    end

    it 'displays the Dasboard button' do
      render 'shared/navbar'

      expect(rendered).to include(t('shared.navbar.dashboard'))
    end
  end
end
