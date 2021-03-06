# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_giveaway, only: %i[create edit update]
  before_action :find_comment, only: %i[edit update destroy]

  def create
    @comment = @giveaway.comments.build(comment_params)
    @comment.user = current_user

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

  def destroy
    @comment.destroy

    redirect_to @comment.giveaway, alert: 'Deleted comment!'
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_giveaway
    @giveaway = Giveaway.find(params[:giveaway_id])
  end

  def find_comment
    @comment = Comment.find_by!(giveaway_id: params[:giveaway_id], id: params[:id])
  end
end
