class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      require 'jwt'
      payload = {data: "test"}
      puts "hello"
      token = JWT.encode payload, ENV["jwt_secret"], true, {algorithm: "HS256"}
      respond_to do |format|
        format.json { render json: token }
        # format.html { redirect_to dashboard_path}
      end
    else
      respond_to do |format|
        format.json { render json: { message: "invalid" } }
      end
    end

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
