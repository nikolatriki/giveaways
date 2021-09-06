# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject(:comment) { create(:comment) }

  describe 'validation' do
    it { expect(comment).to validate_presence_of(:commenter) }
    it { expect(comment).to validate_presence_of(:body) }
  end

  describe 'assosiations' do
    it { expect(comment).to belong_to(:giveaway) }
  end
end
