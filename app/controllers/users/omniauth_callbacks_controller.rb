class Users::OmniauthCallbacksController < ApplicationController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in @user, event: :authentication
      render json: { user: @user, jwt: current_token }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def failure
    render json: { errors: 'Authentication failed' }, status: :unprocessable_entity
  end

  private

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
