class HomesController < ApplicationController
  before_action :authenticate, :dashboard

  def index
  	respond_to do |format|
  	  format.json{ render json: { message: "This is home"} }
  	  format.html{ render :index }
  	end
  end

  def dashboard
  	respond_to do |format|
  	  format.json{ render json: { message: "Welcome to Dashboard, #{ current_user['name'] }"} }
  	  format.html{ render :dashboard}
  	end
  end

end
