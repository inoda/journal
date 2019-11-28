class Post < ApplicationRecord
  validates_presence_of :title, :content
  validates_uniqueness_of :sharing_token, allow_nil: true

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

  def decrypted_sharing_token
    Encryptor.decrypt(self.sharing_token, self.sharing_token_iv)
  end

  def self.encrypted_sharing_token(val)
    Encryptor.encrypt(val, Base64.decode64(ENV['SHARING_TOKEN_CIPHER_IV']))[0]
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

  def sharing_token=(value)
    if value != nil
      encrypted, iv = Encryptor.encrypt(value, Base64.decode64(ENV['SHARING_TOKEN_CIPHER_IV']))
      self.sharing_token_iv = iv
    else
      encrypted = nil
      self.sharing_token_iv = nil
    end

    super(encrypted)
  end

  private

  def ensure_title
    self.title = "Untitled" unless self.title.present?
  end
end
