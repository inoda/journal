class Prompt < ApplicationRecord
  validates_presence_of :content

  def decrypted_content
    Encryptor.decrypt(self.content, self.content_iv)
  end

  def content=(value)
    encrypted, iv = Encryptor.encrypt(value)
    self.content_iv = iv
    super(encrypted)
  end
end
