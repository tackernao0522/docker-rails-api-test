# frozen_string_literal: true

Rails.application.routes.draw do
  post 'auth/:provider/callback', to: 'api/v1/users#create'
  delete 'users/:email', to: 'api/v1/users#destroy', constraints: { email: %r{[^/]+} }

  # 追加: rootルートを設定（APIモードで実際のビューは提供しないが、ルートエラーを避けるため）
  root to: proc { [200, {}, ['']] }
end
