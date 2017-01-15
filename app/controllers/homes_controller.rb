class HomesController < ApplicationController
  before_action :authenticate, :dashboard

  def index
  end

  def dashboard
  end

end
