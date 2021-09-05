require 'rails_helper'

RSpec.describe 'giveaways/show', type: :view do
  let(:giveaway) { create(:giveaway) }
  let(:comment) { create(:comment) }

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

  it 'displays the footer elements' do
    render
    expect(rendered).to include('Back', 'fas fa-edit fa-2x', 'far fa-trash-alt fa-2x', 'New Comment')
  end
end
