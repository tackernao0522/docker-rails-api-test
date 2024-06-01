FROM ruby:3.2.3

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y curl gnupg vim && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs postgresql-client

# アプリケーションディレクトリの作成
RUN mkdir /myapp
WORKDIR /myapp

# GemfileとGemfile.lockをコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# Bundlerのインストール
RUN gem install bundler

# Gemをインストール
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . /myapp

# 環境変数PORTを設定（デフォルトは3000）
ENV PORT=3000

# 指定されたポートを公開
EXPOSE $PORT

# サーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
