# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Giveaways', type: :system do
  before do
    driven_by :selenium, using: :firefox

    visit root_path
  end

  it 'shows the Home link' do
    expecting = page.has_link?('Home')

    expect(expecting).to be true
  end

  context 'when no user is signed in' do
    it 'Shows the Log In link' do
      expecting = page.has_link?('Log In')

      expect(expecting).to be true
    end

    it 'Shows the Sign Up link' do
      expecting = page.has_link?('Sign Up')

      expect(expecting).to be true
    end
  end

  context 'when user is signed in' do
    before do
      user = create(:user)

      visit new_user_session_path

      within('form') do
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
        click_on 'Log In'
      end

      visit root_path
    end

    it 'Shows the Dashboard link' do
      expecting = page.has_link?('Dashboard')

      expect(expecting).to be true
    end

    it 'Shows the Log Out link' do
      expecting = page.has_link?('Log Out')

      expect(expecting).to be true
    end
  end

  context 'when a giveaways is present on the page' do
    let!(:giveaway) { create(:giveaway, title: 'New title', description: 'Some description', location: 'Delchevo') }

    before do
      visit root_path
    end

    it 'Shows the giveaway title' do
      expecting = page.has_content?(giveaway.title)

      expect(expecting).to be true
    end

    it 'Shows the giveaway location' do
      expecting = page.has_content?(giveaway.location)

      expect(expecting).to be true
    end
  end
end
