class ApplicationController < ActionController::Base
  require 'jwt'
  attr_reader :current_user
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  def authenticate
    respond_to do |format|
      format.json { 
        @current_user ||= begin
          decoded_token = JsonWebToken.decode(request.headers[:HTTP_AUTHORIZATION].split(' ')[1])
          current_user = decoded_token[0]
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          nil
        end
      }
      format.html { 
        @current_user ||= begin
          decoded_token = JsonWebToken.decode(session[:access_token])
          current_user = decoded_token[0]
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          nil
        end
      }
    end
    if @current_user
      respond_to do |format|
        format.json { render json: { current_user: @current_user } }
        format.html { return }
      end
    else
      respond_to do |format|
        format.json { render json: { message: "Not authorized!" } }
        format.html { redirect_to new_session_path }
      end
    end

  end
end
