# frozen_string_literal: true

class ClaimsController < ApplicationController
  before_action :set_giveaway

  def create
    @claim = @giveaway.claims.new
    @claim.user = current_user

    @claim.save
    redirect_to giveaway_path(@giveaway), notice: 'You successfully claimed this giveaway!'
  end

  private

  def set_giveaway
    @giveaway = Giveaway.find(params[:giveaway_id])
  end
end
