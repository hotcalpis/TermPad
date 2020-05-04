# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :fav_posts, through: :favorites, source: :post
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: :Relationship, foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  validates :name,    presence: true, length: { maximum: 50 }
  validates :profile, length: { maximum: 400 }
  validates :email,   presence: true, length: { maximum: 255 },
                      uniqueness: { case_sensitive: false }

  def followed_by?(other_user)
    other_user.relationships.find_by(follow_id: id)
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)      default(""), not null
#  profile                :text(65535)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
