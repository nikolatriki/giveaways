# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/giveaways/edit.html.erb' do
  let(:user) { create(:user) }
  let(:giveaway) { create(:giveaway, user: user) }
  let(:heading) { 'Edit Giveaway' }
  let(:cancel_path) { dashboard_giveaway_path(giveaway) }

  it 'displays giveaways form' do
    assign(:giveaway, giveaway)
    render partial: 'form', locals: { heading: heading, cancel_path: cancel_path }

    expect(rendered).to include('Title', 'Description', 'Location')
  end

  it 'displays form header' do
    assign(:giveaway, giveaway)
    render partial: 'form', locals: { heading: heading, cancel_path: cancel_path }

    render

    expect(rendered).to include('Edit Giveaway')
  end
end