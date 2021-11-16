# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Giveaway, type: :model do
  subject(:giveaway) { create(:giveaway, user: user) }

  let(:user) { create(:user) }

  describe 'validations' do
    it { expect(giveaway).to validate_presence_of(:title) }
    it { expect(giveaway).to validate_presence_of(:description) }
    it { expect(giveaway).to validate_presence_of(:location) }
  end

  describe 'associations' do
    it { expect(giveaway).to have_many(:comments) }
    it { expect(giveaway).to have_many(:pictures) }
    it { expect(giveaway).to have_many(:claims) }
    it { expect(giveaway).to belong_to(:user) }
  end

  describe 'dependency' do
    it { expect(giveaway).to have_many(:comments).dependent(:destroy) }
    it { expect(giveaway).to have_many(:pictures).dependent(:destroy) }
    it { expect(giveaway).to have_many(:claims).dependent(:destroy) }

    it 'destroys comments' do
      create_list(:comment, 1, giveaway: giveaway)
      expect { giveaway.destroy }.to change(Comment, :count).by(-1)
    end

    it 'destroys pictures' do
      create_list(:picture, 1, giveaway: giveaway)
      expect { giveaway.destroy }.to change(Picture, :count).by(-1)
    end

    it 'destroys claims' do
      create_list(:claim, 1, giveaway: giveaway)
      expect { giveaway.destroy }.to change(Claim, :count).by(-1)
    end
  end
end
