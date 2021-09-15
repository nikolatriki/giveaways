class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user&.authenticate(params[:session][:password])
      log_in(user)
      flash[:success] = "Welcome back, #{user.name}!"
      redirect_to user
    else
      flash.now[:danger] = 'Invalid password or not such an email exists'
      render :new
    end
  end

  def destroy
  end
end