module SessionsHelper
  # Logs the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Importante recordar que el simple hecho de inciar sesión NO genera un current user
  # Un primer momento es iniciar sesión
  # Inmediatamante despues se crea el current user, pero hasta este punto y no antes.

  # Returns the current logged-in user (if any).
  # línea 15 hay inicio de sesión?
  # Línea 16 la primera vez que se inicia sesión NO hay current user entonces resuelve el lado derecho y entonces asigna a @current user la instancia que devuelve el find_by.
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by_id(session[:user_id])
    end
  end

  # Returns true if the user is logged in false otherwise
  def logged_in?
    !current_user.nil?
  end

  def log_out
    reset_session
    @current_user = nil
  end
end
