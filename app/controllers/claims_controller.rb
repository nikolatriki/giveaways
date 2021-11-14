class ClaimsController < ApplicationController
  before_action :set_giveaway

  def create
    @claim = @giveaway.claims.build(claim_params)
    @claim.user = current_user

    if @claim.save
      redirect_to @giveaway
    else
      render root_path
    end
  end

  private

  def claim_params
    params.require(:claim).permit(:giveaway_id)
  end

  def set_giveaway
    @giveaway = Giveaway.find(params[:giveaway_id])
  end
end
