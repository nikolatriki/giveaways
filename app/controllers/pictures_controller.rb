# frozen_string_literal: true

class PicturesController < ApplicationController
  def destroy
    @picture = Picture.find(params[:id])
    @giveaway = @picture.giveaway
    @picture.destroy

    redirect_to edit_dashboard_giveaway_path(@giveaway), notice: 'Deleted picture!'
  end
end
