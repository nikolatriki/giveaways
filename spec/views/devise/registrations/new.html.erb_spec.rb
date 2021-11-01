# frozen_string_literal: true

require 'rails_helper'
require 'support/devise_invalid_user_helper'

describe 'devise/registrations/new.html.erb' do # rubocop:disable RSpec/DescribeClass
  it 'renders error messages' do
    view.class.include DeviseInvalidUserHelper

    render

    %w[name email password].each do |field_name|
      expect(rendered).to include("#{field_name.humanize} can&#39;t be blank")
    end
  end
end
