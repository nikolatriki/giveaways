# frozen_string_literal: true

class PicturesController < ApplicationController
  def new
    @giveaway = Giveaway.find(params[:giveaway_id])
    @picture = @giveaway.pictures.build
  end

  def create
    @giveaway = Giveaway.find(params[:giveaway_id])

    @picture = @giveaway.pictures.build(picture_params)
    @picture.user = current_user

    if @picture.save
      flash[:info] = 'Added picture!'
      redirect_to @giveaway
    else
      render :new
    end
  end

  private

  def picture_params
    params.require(:picture).permit(:id)
  end
end
