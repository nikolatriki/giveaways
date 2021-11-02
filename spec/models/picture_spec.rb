# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Picture, type: :model do
  subject(:picture) { create(:picture, giveaway: giveaway) }

  let(:giveaway) { create(:giveaway, user: user) }
  let(:user) { create(:user) }

  before do
    picture.image.attach(fixture_file_upload(file_fixture('seat.jpg'), 'image/jpeg'))
  end

  describe 'validation' do
    it { expect(picture.image.content_type).to eq('image/jpeg') }
    it { expect(picture.image.content_type).not_to eq('image/gif') }
  end

  describe 'assosiations' do
    it { expect(picture).to belong_to(:giveaway) }
    it { expect(picture).to have_one_attached(:image) }
  end
end
