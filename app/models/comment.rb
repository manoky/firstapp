class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  scope :rating_desc, -> { order(rating: :desc) }
  scope :rating_asc, -> { order(rating: :asc) }
  validates :body, presence: true
  validates :user, presence: true
  validates :product, presence: true
  validates :rating, numericality: { only_integer: true }
  ActionCable.server.broadcast 'product_channel', comment: "Hello World", average_rating: 5
end

