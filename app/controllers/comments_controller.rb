# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_comment, only: %i[edit update]

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

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @giveaway
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def find_comment
    @giveaway = Giveaway.find(params[:giveaway_id])
    @comment = Comment.find(params[:id])
  end
end
