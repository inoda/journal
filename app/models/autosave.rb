class Autosave < ApplicationRecord
  def decrypted_content
    return '' unless self.content_iv.present? && self.content.present?
    Encryptor.decrypt(self.content, self.content_iv)
  end

  def decrypted_title
    return '' unless self.title_iv.present? && self.title.present?
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
end
