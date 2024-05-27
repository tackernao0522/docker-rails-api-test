# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0] # rubocop:disable Style/Documentation
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, unique: true, limit: 255
      t.string :provider, null: false
      t.string :uid, null: false, unique: true
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, %i[provider uid], unique: true
  end
end
