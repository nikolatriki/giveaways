# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    session_notice(:warning, 'You are already logged in!') if logged_in?
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      log_in(user)
      redirect_to user, notice: "Welcome back, #{user.name}!"
    else
      flash.now[:danger] = 'Invalid password or not such an email exists'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
