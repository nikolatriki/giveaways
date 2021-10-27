# frozen_string_literal: true

require 'rails_helper'

describe 'giveaways/show', type: :view do
  include SessionsHelper

  let!(:user) { create(:user) }
  let!(:giveaway) { create(:giveaway, user: user) }
  let!(:comment) { create(:comment, giveaway: giveaway, user: user) }

  before do
    assign(:giveaway, giveaway)
    assign(:comment, comment)
    assign(:comments, [comment])
  end

  context 'when displaying giveaway card' do
    it 'displays the giveaway attributes' do
      render
      expect(rendered).to include(giveaway.title, giveaway.location)
    end

    it 'displays an image of the giveaway' do
      render
      expect(rendered).to have_css('.image')
    end
  end

  context 'without logged in user' do
    let(:comments) { [comment] }

    it 'footer displays only Back button' do
      render

      expect(rendered).to include('Back')
    end

    it 'page displays the comments under the giveaway' do
      render

      expect(rendered).to include(comment.user.name)
    end
  end

  context 'with logged in user' do
    before { log_in user }

    it 'footer displays edit button' do
      render

      expect(rendered).to have_css('.fas')
    end

    it 'footer displays delete button' do
      render

      expect(rendered).to have_css('.far')
    end

    it 'page displays the comments form under the giveaway' do
      render partial: 'comments/form'

      expect(rendered).to include('Leave a comment...')
    end
  end
end
