# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'comments/comment' do
  let(:user) { create(:user) }
  let(:giveaway) { create(:giveaway, user: user) }
  let(:comment) { create(:comment, giveaway: giveaway) }

  it 'displays comment partial' do
    assign(:giveaways, [giveaway])

    render partial: 'comments/comment', locals: { comment: comment }

    expect(rendered).to include(comment.user.name.capitalize)
  end
end
