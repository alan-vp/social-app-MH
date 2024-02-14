class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])  # anteriormente if user && user.authenticate(params[:session][:password])
      reset_session
      log_in(user)
      redirect_to user # user_path(user) esto es = que solo user
    else
      flash.now[:danger] = 'Invlid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_path, status: :see_other
  end
end
