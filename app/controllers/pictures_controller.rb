# frozen_string_literal: true

class PicturesController < ApplicationController
  def destroy
    @picture = Picture.find(params[:id])
    @giveaway = @picture.giveaway

    if logged_in? && @giveaway.user == current_user
      @picture.destroy

      flash[:info] = 'Deleted picture!'
    end

    redirect_to @giveaway
  end
end
