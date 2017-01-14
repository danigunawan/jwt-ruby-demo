class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      require 'jwt'
      payload = {data: "test"}
      puts JWT_SECRET
      token = JWT.encode payload, "thisissecretkey", "HS256"
      respond_to do |format|
        format.json { render json: { token: token } }
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
