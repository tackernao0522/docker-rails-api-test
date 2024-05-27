# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Style/Documentation
  has_secure_password

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :password, length: { minimum: 8, maximum: 128 }, allow_nil: true
end
