require 'rails_helper'

RSpec.describe 'giveaways/show', type: :view do
  let(:giveaway) { create(:giveaway) }

  it 'displays the giveaway attributes' do
    assign(:giveaway, giveaway)
    render
    expect(rendered).to include(giveaway.title, giveaway.location)
  end

  it 'display an image of the giveaway' do
    assign(:giveaway, giveaway)
    render
    expect(rendered).to include('212-2127438_decent-giveaways-png')
  end

  it 'displays the footer elements' do
    assign(:giveaway, giveaway)
    render
    expect(rendered).to include('Back', 'fas fa-edit fa-2x', 'far fa-trash-alt fa-2x', 'New Comment')
  end

  context 'with comments' do
    before do
      assign()
    end

    it 'displays comments' do
      render

      rendered.should contain(giveaway.comments)
    end
  end
end
