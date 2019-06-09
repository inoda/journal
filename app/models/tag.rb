class Tag < ApplicationRecord
  validates_presence_of :label

  has_many :post_tags
  has_many :posts, through: :post_tags
end
