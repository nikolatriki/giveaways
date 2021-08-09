class GiveawaysController < ApplicationController
  def index
    @giveaways = Giveaway.all
  end

  def show
    @giveaway = Giveaway.find(params[:id])
  end

  def new
  end

  def create
    giveaway = Giveaway.new(giveaway_params)
    giveaway.save

    redirect_to giveaway_path(giveaway)
    # render plain: params[:giveaway].inspect -for checking the parametars hash created
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def giveaway_params
    params.require(:giveaway).permit(:title, :description, :location)
    # I found out that it can be written as:
    # params[:giveaway].permit(:title, :description, :location)
    # :giveaway is the key from the params hash created with 'form_with' helper using 'scope:', or 'model:' methods
    # If you don't have scoped parametars, there is no need for require method in strong params altogether.
  end
end
