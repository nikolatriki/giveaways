# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  describe 'validations' do
    it { expect(user).to validate_presence_of(:name) }
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_presence_of(:password).ignoring_interference_by_writer }
    it { expect(user).to validate_uniqueness_of(:email).case_insensitive }
    it { expect(user).to have_secure_password }
    it { expect(user).to validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGTH) }
    it { expect(user).to validate_length_of(:name).is_at_most(User::MAXIMUM_NAME_LENGTH) }
    it { expect(user).to validate_length_of(:email).is_at_most(User::MAXIMUM_EMAIL_LENGTH) }
  end

  describe 'associations' do
    it { expect(user).to have_many(:giveaways) }
  end

  describe 'dependency' do
    it { expect(user).to have_many(:giveaways).dependent(:destroy) }
  end

  context 'with email downcase' do
    let(:valid_email) { 'TEST@TEST.COM' }
    let(:valid_user) { create(:user, email: valid_email) }

    it 'transforme email to downcase' do
      expect(valid_user.email).to eq(valid_email.downcase)
    end
  end

  context 'when invalid email format' do
    let(:invalid_user) { build(:user, email: 'test@invalid') }

    it 'is invalid' do
      expect(invalid_user.valid?).to be false
    end
  end


end
