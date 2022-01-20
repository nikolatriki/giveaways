require 'rails_helper'

RSpec.describe GiveawayPolicy do
  subject { described_class }

  let!(:user) { create(:user)}
  let!(:giveaway) { create(:giveaway, user: user)}

  permissions :show?, :edit?, :update?, :destroy? do

    it 'denies access if user is not the correct user' do
      expect(subject).not_to permit(user != giveaway.user, giveaway[:edit] )
    end

    # it 'grants access if user is the correct user' do
    #   expect(subject).to permit(user(correct_user: true))
    # end
  end
end
