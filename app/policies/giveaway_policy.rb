# frozen_string_literal: true

class GiveawayPolicy < ApplicationPolicy
  def show?
    @user == @record.user
  end

  def edit?
    @user == @record.user
  end

  def update?
    @user == @record.user
  end

  def destroy?
    @user == @record.user
  end
end
