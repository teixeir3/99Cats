class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    if @user.nil?
      flash[:error] = "Credentials are wrong"
    else
      flash[:notice] = "Welcome back #{@user.user_name}"
    end

    session[:session_token] = @user.session_token

    redirect_to cats_url
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end

  def new
  end

end
