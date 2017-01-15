class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user.authenticate(params[:user][:password])
      require 'jwt'
      payload = { name: @user.name }
      token = JWT.encode payload, "thisissecretkey", "HS256"
      session[:current_user_id] = @user.id
      respond_to do |format|
        format.json { render json: { token: token } }
        format.html { redirect_to dashboard_path, notice: "Signed in successfully!" }
      end
    else
      respond_to do |format|
        format.json { render json: { message: "invalid" } }
        format.html { redirect_to new_session_path, notice: "Wrong credentials!" }
      end
    end

  end

  def destroy

  end
end
