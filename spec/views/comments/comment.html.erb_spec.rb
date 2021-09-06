# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'comments/comment' do # rubocop:disable RSpec/DescribeClass
  let(:giveaway) { create(:giveaway) }
  let(:comment) { create(:comment, giveaway: giveaway) }

  it 'displays comment partial' do
    assign(:giveaways, [giveaway])

    render partial: 'comments/comment', locals: { comment: comment }

    expect(rendered).to include(comment.commenter)
  end
end
