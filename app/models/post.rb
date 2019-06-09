class Post < ApplicationRecord
  validates_presence_of :title

  has_many :post_tags, dependent: :delete_all
  has_many :tags, through: :post_tags

  scope :search, -> q { left_outer_joins(:tags).where("posts.title ILIKE ? OR tags.label ILIKE ?", "%#{q}%", "%#{q}%") if !q.nil? && q.strip.present? }
end
