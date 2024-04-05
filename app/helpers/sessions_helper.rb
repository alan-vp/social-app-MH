module SessionsHelper
  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
    # Guard against session replay atacks
    # See https://bit.ly/33UvK0w for more.
    session[:session_token] = user.session_token
  end

  # Remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Importante recordar que el simple hecho de inciar sesión NO genera un current user
  # Un primer momento es iniciar sesión
  # Inmediatamente despues se crea el current user, pero hasta este punto y no antes.

  # Returns the user corresponding to the remember token cookie
  def current_user
    if (user_id = session[:user_id])
      user = User.find_by_id(id: user_id)
      if user && session[:session_token] == user.FILL_IN
        @current_user = user
      end
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    # Todo lo comentado era la sintaxis propuesta originalmente para el método #current_user", hasta que se refactorizó de acuerdo a lo señalado en la página 369.
    # if session[:user_id]
    #   @current_user ||= User.find_by_id(session[:user_id])
    # elsif cookies.encrypted[:user_id]
    #   user = User.find_by(id: cookies.encrypted[:user_id])
    #   if user && user.authenticated?
    #     (cookies[:remember_token])
    #     log_in user
    #     @current_user = user
    #   end
    # end
  end

  # Returns true if the user is logged in false otherwise
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Log out the current user.
  def log_out
    forget(current_user)
    reset_session
    @current_user = nil
  end

end
