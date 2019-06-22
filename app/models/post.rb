class Post < ApplicationRecord
  validates_presence_of :title, :content
  validates_uniqueness_of :sharing_token, allow_nil: true

  has_many :post_tags, dependent: :delete_all
  has_many :tags, through: :post_tags

  scope :has_tag, -> q { left_outer_joins(:tags).where("tags.label": Tag.encrypted_label(q)) if !q.nil? && q.strip.present? }

  before_validation :ensure_title

  def shared?
    sharing_token.present?
  end

  def decrypted_content
    Encryptor.decrypt(self.content, self.content_iv)
  end

  def decrypted_title
    Encryptor.decrypt(self.title, self.title_iv)
  end

  def content=(value)
    encrypted, iv = Encryptor.encrypt(value)
    self.content_iv = iv
    super(encrypted)
  end

  def title=(value)
    encrypted, iv = Encryptor.encrypt(value)
    self.title_iv = iv
    super(encrypted)
  end

  private

  def ensure_title
    self.title = "Untitled" unless self.title.present?
  end
end
