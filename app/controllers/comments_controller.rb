# frozen_string_literal: true

class CommentsController < ApplicationController
  def new
    @giveaway = Giveaway.find(params[:giveaway_id])
    @comment = @giveaway.comments.build
  end

  def create
    giveaway = Giveaway.find(params[:giveaway_id])
    comment = giveaway.comments.build(comment_params)

    comment.save
    redirect_to giveaway
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
