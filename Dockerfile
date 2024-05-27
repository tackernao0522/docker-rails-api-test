FROM ruby:3.2.3

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y curl gnupg && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get install -y postgresql-client

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

# ポート3000を公開
EXPOSE 3000

# サーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
