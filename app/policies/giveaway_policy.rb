# frozen_string_literal: true

class GiveawayPolicy < ApplicationPolicy
  def edit?
    @user == @record.user
  end
end
