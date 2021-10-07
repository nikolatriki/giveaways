# frozen_string_literal: true

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

  def session_notice(type, message, path = root_path)
    flash[type.to_sym] = message
    redirect_to path and return
  end

  def must_be_logged_in_notice
    session_notice(:danger, 'You must be logged in!', login_path) unless logged_in?
  end
end
