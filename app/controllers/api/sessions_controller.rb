class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      render json: ["Invalid Credentials"], status: 401
    else
      login(@user)
      render :show
    end
  end

  def destroy
    logout
    unless current_user
      render json: @user.errors.full_messages, status: 404
    end
    render json: {}
  end

end
