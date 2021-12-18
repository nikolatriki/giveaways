# frozen_string_literal: true

require 'rails_helper'

describe 'contacts/new.html.erb' do
  it 'renders header and paragraph' do
    assign(:contact, build(:contact))

    render

    expect(rendered).to include('Contact Us')
    expect(rendered).to include('In case of a question')
  end

  it 'renders social media icons' do
    assign(:contact, build(:contact))

    render

    expect(rendered).to include('https://instagram.com')
    expect(rendered).to include('https://twitter.com')
    expect(rendered).to include('https://facebook.com')
  end
end
