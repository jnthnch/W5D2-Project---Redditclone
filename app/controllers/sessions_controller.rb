class SessionsController < ApplicationController

  def new
  end

  def create
    user = user.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      login(user)
      redirect_to subs_url
    else
      flash.now[:errors] = ['invalid login']
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end
end
