class Post < ApplicationRecord
  validates_presence_of :title

  has_many :post_tags, dependent: :delete_all
  has_many :tags, through: :post_tags

  scope :search, -> q { left_outer_joins(:tags).where("posts.title ILIKE ? OR tags.label ILIKE ?", "%#{q}%", "%#{q}%") if !q.nil? && q.strip.present? }

  before_save :encrypt

  def decrypted_content
    return "" if !self.content_iv || self.content.strip.blank?
    Encryptor.decrypt(self.content, self.content_iv)
  end

  def decrypted_title
    return "" if !self.title_iv || self.title.strip.blank?
    Encryptor.decrypt(self.title, self.title_iv)
  end

  private

  def encrypt
    self.content, self.content_iv = Encryptor.encrypt(self.content)
    self.title, self.title_iv = Encryptor.encrypt(self.title)
  end
end
