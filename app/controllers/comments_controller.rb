# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @giveaway = Giveaway.find(params[:giveaway_id])
    @comment = @giveaway.comments.build
  end

  def create
    @giveaway = Giveaway.find(params[:giveaway_id])
    @comment = @giveaway.comments.build(comment_params)

    if @comment.save
      redirect_to @giveaway
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
