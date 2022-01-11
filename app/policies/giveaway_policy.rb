# frozen_string_literal: true

class GiveawayPolicy < ApplicationPolicy
  def show?
    correct_user
  end

  def edit?
    correct_user
  end

  def update?
    correct_user
  end

  def destroy?
    correct_user
  end

  private

  def correct_user
    @user == @record.user
  end
end
