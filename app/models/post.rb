class Post < ApplicationRecord
  validates_presence_of :title

  has_many :post_tags, dependent: :delete_all
  has_many :tags, through: :post_tags

  def tags_list
    tags.map(&:label).join(", ")
  end
end
