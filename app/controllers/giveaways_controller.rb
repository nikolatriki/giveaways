# frozen_string_literal: true

class GiveawaysController < ApplicationController
  include Pagy::Backend

  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_giveaway, only: %i[show edit update destroy]

  def index
    @pagy, @giveaways = pagy(Giveaway.search(params[:search]).order(created_at: :desc), items: 18)
  end

  def show
    @comments = @giveaway.comments.order(created_at: :desc)

    @comment = @giveaway.comments.build
  end

  def new
    @giveaway = Giveaway.new
  end

  def create
    @giveaway = Giveaway.new(giveaway_params)
    @giveaway.user = current_user

    if @giveaway.save
      redirect_to @giveaway, notice: t('controllers.giveaways.notice')
    else
      render :new
    end
  end

  def edit; end

  def update
    if @giveaway.update(giveaway_params)
      redirect_to @giveaway
    else
      render :edit
    end
  end

  def destroy
    @giveaway.destroy

    redirect_to giveaways_path, alert: t('controllers.giveaways.alert')
  end

  private

  def giveaway_params
    params.require(:giveaway).permit(:title, :description, :location, :search,
                                      pictures_attributes: %i[id title image _destroy])
    # I found out that it can be written as:
    # params[:giveaway].permit(:title, :description, :location)
    # :giveaway is the key from the params hash created with 'form_with' helper using 'scope:', or 'model:' methods
    # If you don't have scoped parametars, there is no need for require method in strong params altogether.
  end

  def find_giveaway
    @giveaway = Giveaway.find(params[:id])
  end
end
