# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Claim, type: :model do
  subject(:claim) { create(:claim, giveaway: giveaway, user: user) }

  let(:giveaway) { create(:giveaway, user: user) }
  let(:user) { create(:user) }

  describe 'associations' do
    it { expect(claim).to belong_to(:giveaway) }
    it { expect(claim).to belong_to(:user) }
  end

  describe 'validations' do
    it { expect(claim).to validate_uniqueness_of(:user_id).scoped_to(:giveaway_id) }
  end
end
