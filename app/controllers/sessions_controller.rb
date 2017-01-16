class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user.authenticate(params[:user][:password])
      require 'jwt'
      payload = { exp: Time.now.to_i + 3600, id: @user.id, name: @user.name }
      token = JWT.encode payload, Rails.application.secrets.JWT_SECRET, "HS256"
      session[:access_token] = token
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
    reset_session
    respond_to do |format|
      format.json{ render json: { message: "Not authorized!" } }
      format.html{ redirect_to new_session_path }
    end
    
  end
end
