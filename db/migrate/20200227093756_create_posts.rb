# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true, null: false
      t.string :theme, null: false
      t.text :description, null: false

      t.timestamps null: false
    end
    add_index :posts, %i[user_id created_at]
  end
end
