# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contact, type: :model do
  subject(:contact) { create(:contact) }

  describe 'validations' do
    it { expect(contact).to be_valid }
    it { expect(contact).to validate_presence_of(:name) }
    it { expect(contact).to validate_presence_of(:email) }
    it { expect(contact).to validate_presence_of(:message) }
  end
end
