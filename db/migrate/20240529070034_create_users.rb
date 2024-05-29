# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0] # rubocop:disable Style/Documentation
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
