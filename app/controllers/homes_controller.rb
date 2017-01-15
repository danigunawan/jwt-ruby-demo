class HomesController < ApplicationController
  before_filter :authenticate

  def index
  end

  def dashboard
  end

  def authenticate
    if session[:current_user_id]
      return
    else
      render :index
    end
  end

end
