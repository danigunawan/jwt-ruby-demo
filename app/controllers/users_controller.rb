class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.json{ @user }
        format.html{ redirect_to root_path}
      end
    else
      respond_to do |format|
        format.json{ "Failed to create a user." }
        format.html{ render :new }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
