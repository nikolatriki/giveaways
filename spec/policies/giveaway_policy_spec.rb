require 'rails_helper'

RSpec.describe GiveawayPolicy do
  subject { described_class.new(user, giveaway) }

  let(:giveaway) { Giveaway.create }

  context 'when being different user than the giveaway user in dashboard' do
    let(:user) { create(:user) }

    it { is_expected.to forbid_actions(%i[show edit update destroy]) }
  end

  context 'when being the same user as the giveaway user in dashboard' do
    let(:user) { giveaway.user }

    it { is_expected.to permit_actions(%i[show edit update destroy]) }
  end

  permissions :show?, :edit?, :update?, :destroy? do
    it 'denies access if giveaway is from another user'

    it 'grants access if giveaway is from current user'
  end
end
