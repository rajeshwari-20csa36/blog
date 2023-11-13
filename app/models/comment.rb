class Comment < ApplicationRecord
  belongs_to :post, counter_cache: true
  belongs_to :user
  has_many :user_comment_ratings
  has_many :users, through: :user_comment_ratings

  validates :content, presence: true
end
