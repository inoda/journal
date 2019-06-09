class Tag < ApplicationRecord
  validates_presence_of :label

  has_many :post_tags
  has_many :posts, through: :post_tags

  before_save :encrypt

  def decrypted_label
    return "" if !self.label_iv || self.label.strip.blank?
    Encryptor.decrypt(self.label, self.label_iv)
  end

  private

  def encrypt
    self.label, self.label_iv = Encryptor.encrypt(self.label)
  end
end
