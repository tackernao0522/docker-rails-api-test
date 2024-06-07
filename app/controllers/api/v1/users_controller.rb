# frozen_string_literal: true
module Api # rubocop:disable Layout/EmptyLineAfterMagicComment
  module V1
    class UsersController < ApplicationController # rubocop:disable Style/Documentation
      def create
        user = User.find_or_create_by(provider: params[:provider], uid: params[:uid], name: params[:name],
                                      email: params[:email])
        if user
          head :ok
        else
          render json: { error: 'ログインに失敗しました' }, status: :unprocessable_entity
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end

      def destroy
        user = User.find_by(email: params[:email])
        if user
          user.destroy
          head :no_content # 成功レスポンスを追加
        else
          render json: { error: 'ユーザーが見つかりませんでした' }, status: :not_found
        end
      rescue StandardError => e
        render json: { error: e.message }, status: :internal_server_error
      end
    end
  end
end
