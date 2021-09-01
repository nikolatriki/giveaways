# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Giveaway, type: :model do
  subject(:givey) { create(:giveaway) }

  describe 'validations' do
    it { expect(givey).to validate_presence_of(:title) }
    it { expect(givey).to validate_presence_of(:description) }
    it { expect(givey).to validate_presence_of(:location) }
  end
end
