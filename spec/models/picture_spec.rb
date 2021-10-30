# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Picture, type: :model do
  subject(:picture) { create(:picture, giveaway: giveaway) }

  let(:giveaway) { create(:giveaway, user: user) }
  let(:user) { create(:user) }

  describe 'validation' do
    it { expect(picture).to validate_attachment(image: 'image/png') }
  end

  describe 'assosiations' do
    it { expect(picture).to belong_to(:giveaway) }
    it { expect(picture).to have_one_attached(:image) }
  end
end

