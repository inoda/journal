class Tag < ApplicationRecord
  validates_presence_of :label

  has_many :post_tags
  has_many :posts, through: :post_tags

  def self.encrypted_label(val)
    Encryptor.encrypt(val, Base64.decode64(ENV['TAG_CIPHER_IV']))[0]
  end

  def decrypted_label
    Encryptor.decrypt(self.label, self.label_iv)
  end

  def label=(value)
    encrypted, iv = Encryptor.encrypt(value, Base64.decode64(ENV['TAG_CIPHER_IV']))
    self.label_iv = iv
    super(encrypted)
  end
end
