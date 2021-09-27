# frozen_string_literal: true

class GiveawaysController < ApplicationController
  before_action :must_be_logged_in, only: %i[new edit destroy]
  before_action :find_giveaway, only: %i[show edit update destroy]

  def index
    @giveaways = Giveaway.order(created_at: :desc)
  end

  def show; end

  def new
    @giveaway = Giveaway.new
  end

  def create
    @giveaway = Giveaway.new(giveaway_params)
    @giveaway.user = current_user

    if @giveaway.save
      redirect_to @giveaway # render plain: params[:giveaway].inspect -for checking the parametars hash created
    else
      render :new
    end
  end

  def edit
    if logged_in? && @giveaway.user != current_user
      session_notice(:danger, 'Wrong user!')
    end
  end

  def update
    if @giveaway.update(giveaway_params)
      redirect_to @giveaway
    else
      render :edit
    end
  end

  def destroy
    giveaway.destroy

    redirect_to giveaways_path
  end

  private

  def giveaway_params
    params.require(:giveaway).permit(:title, :description, :location)
    # I found out that it can be written as:
    # params[:giveaway].permit(:title, :description, :location)
    # :giveaway is the key from the params hash created with 'form_with' helper using 'scope:', or 'model:' methods
    # If you don't have scoped parametars, there is no need for require method in strong params altogether.
  end

  def find_giveaway
    @giveaway = Giveaway.find(params[:id])
  end

  def must_be_logged_in
    session_notice(:danger, 'You must be logged in!') unless logged_in?
  end
end
