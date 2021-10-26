# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'giveaways/show', type: :view do
  let!(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }
  let!(:comment) { create(:comment, giveaway: giveaway, user: user) }

  before do
    assign(:giveaway, giveaway)
    assign(:comments, [comment])
  end

  it 'displays the giveaway attributes' do
    render
    expect(rendered).to include(giveaway.title, giveaway.location)
  end

  it 'display an image of the giveaway' do
    render
    expect(rendered).to have_css('.image')
  end

  context 'without logged in user' do
    let(:comments){ [ comment ] }

    it 'footer displays only Back button' do
      render

      expect(rendered).to include('Back')
    end

    it 'page displays the comments under the giveaway' do #After 4 hours testing it this test is not working

      render
      comments.each do |comment|
        expect(rendered).to include(comment.to_s)
      end
    end
  end
end
