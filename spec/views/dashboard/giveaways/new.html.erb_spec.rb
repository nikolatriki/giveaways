# frozen_string_literal: true

require 'rails_helper'

describe 'dashboard/giveaways/new.html.erb' do
  let(:heading) { 'New Giveaway' }
  let(:cancel_path) { dashboard_giveaways_path }

  it 'displays giveaways form' do
    assign(:giveaway, Giveaway.new)
    render partial: 'form', locals: { heading: heading, cancel_path: cancel_path }

    expect(rendered).to include('Title', 'Description', 'Location')
  end

  it 'displays error messages' do
    assign(:giveaway, Giveaway.create(title: '', description: '', location: ''))

    render partial: 'form', locals: { heading: heading, cancel_path: cancel_path }

    expect(rendered).to include('Title can&#39;t be blank')
    expect(rendered).to include('Description can&#39;t be blank')
    expect(rendered).to include('Location can&#39;t be blank')
  end
end