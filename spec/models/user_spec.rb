# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context 'when saving the User' do
    it 'transformes email to donwcase' do
      new_user = create(:user, email: 'TEST@TEST.COM')

      expect(new_user.email).to eq('test@test.com')
    end
  end

  context 'when using invalid email format' do
    it 'is invalid' do
      john = build(:user, email: 'test@invalid')
      expect(john.valid?).to be false
    end
  end

  describe 'validations' do
    it { expect(user).to validate_presence_of(:name) }
    it { expect(user).to validate_presence_of(:email) }
    it { expect(user).to validate_presence_of(:password).ignoring_interference_by_writer }

    it { expect(user).to have_secure_password }
  end

  context 'when matching uniqueness of email' do
    it { expect(user).to validate_uniqueness_of(:email) }
  end

  it { is_expected.to validate_length_of(:password).is_at_least(User::MINIMUM_PASSWORD_LENGTH) }
  it { is_expected.to validate_length_of(:name).is_at_most(User::MAXIMUM_NAME_LENGTH) }
  it { is_expected.to validate_length_of(:email).is_at_most(User::MAXIMUM_EMAIL_LENGTH) }
end
