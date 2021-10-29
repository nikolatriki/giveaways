# frozen_string_literal: true

class PicturesController < ApplicationController
  def destroy
    @picture = Picture.find(params[:id])
    @giveaway = @picture.giveaway

    if user_signed_in? && @giveaway.user == current_user
      @picture.destroy

      flash[:info] = 'Deleted picture!'
    end

    redirect_to edit_giveaway_path(@giveaway)
  end
end
