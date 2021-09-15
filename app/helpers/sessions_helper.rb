module SessionsHelper
  def log_in(something)
    session[:user_id] = something.id
  end
end
