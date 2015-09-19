class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user(@user)
      flash[:success] = [ "Welcome to RedditClone" ]
      redirect_to subs_url
      # redirect root_url
    else
      flash.now[:errors]= @user.errors.full_messages
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end
