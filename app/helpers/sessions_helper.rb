module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete(:user_id)
  end

  def logged_in_notice
    flash[:danger] = 'You are already logged in!'
    redirect_to root_path and return
  end
end
