# frozen_string_literal: true

class GiveawaysController < ApplicationController
  include Pagy::Backend

  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_giveaway, only: :show

  def index
    @pagy, @giveaways = pagy(Giveaway.search(params[:search]).order(created_at: :desc), items: 18)
  end

  def show
    @comments = @giveaway.comments.order(created_at: :desc)

    @comment = @giveaway.comments.build
  end

  private

  def find_giveaway
    @giveaway = Giveaway.find(params[:id])
  end
end
