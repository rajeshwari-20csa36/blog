class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :name, presence: true
end
