class Rating < ApplicationRecord
  VALUES = (1..5)
  belongs_to :post

  validates :value, presence: true, inclusion: {in: Rating::VALUES}

  after_commit :update_post_average_rating, on: [:create, :update]
  def update_post_average_rating
    self.post.update!(rating_average: post.ratings.average(:value))
  end
end
