# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :users, through: :favorites

  default_scope -> { order(created_at: :desc) }

  validates :theme, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 20_000 }

  def liked_by?(user)
    user.likes.find_by(post_id: id)
  end
end

# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  description :text(65535)      not null
#  likes_count :integer          default(0)
#  theme       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id                 (user_id)
#  index_posts_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
