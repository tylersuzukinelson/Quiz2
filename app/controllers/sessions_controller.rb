class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to ideas_path, notice: "Successfuly logged in. Welcome, #{@user.first_name}."
      # render json: params
    else
      flash.now[:alert] = 'Unable to authenticate your account.'
      render :new
      # render json: params
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path, notice: 'Signed Out!'
  end

end
