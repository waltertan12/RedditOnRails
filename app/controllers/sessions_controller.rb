class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name],
                                    params[:user][:password])
    if user
      login_user(user)
      flash[:success] = ["Welcome back to RedditClone"]
      redirect_to subs_url
    else
      flash.now[:errors] = ["Username and password did not match"]
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
end
