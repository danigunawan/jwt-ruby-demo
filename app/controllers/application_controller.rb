class ApplicationController < ActionController::Base
  require 'jwt'
  attr_reader :current_user
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  def authenticate
    @current_user ||= begin
      decoded_token = JWT.decode session[:access_token], Rails.application.secrets.JWT_SECRET, true, { :algorithm => 'HS256' }
      current_user = decoded_token[0]
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      nil
    end
    if @current_user
      return
    else
      redirect_to new_session_path
    end

  end
end
