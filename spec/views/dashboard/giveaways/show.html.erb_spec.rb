# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/giveaways/show.html.erb' do
  let(:user) { create(:user) }
  let(:giveaway) { create(:giveaway, user: user) }
  let(:comment) { create(:comment, giveaway: giveaway, user: user) }

  before do
    assign(:giveaway, giveaway)
    assign(:comments, [comment])
  end

  it 'displays the giveaway' do
    render

    expect(rendered).to include(giveaway.title)
  end

  it 'displays giveaway comments section' do
    render

    expect(rendered).to include(comment.user.name.capitalize)
  end
end
