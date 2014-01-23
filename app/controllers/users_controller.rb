class UsersController < ApplicationController

  def new
    @user = User.new

    render :new
  end

  def create
    if params[:password_confirmation] != params[:user][:password]
      flash[:error] = "Password confirmation needs to be the same as password"
      redirect_to new_user_url and return
    end

    @user = User.new(:user_name => params[:user][:user_name])
    @user.password = params[:user][:password]
    if @user.save
      flash[:notice] = "New user created"
      self.current_user = @user
      # session[:session_token] = @user.session_token
      # login(@user)
      redirect_to cats_url
      #redirect_to cats_url
    else
      flash[:error] = "You done screwed up!"
      redirect_to new_user_url
    end
  end

end
