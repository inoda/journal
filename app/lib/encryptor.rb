class Encryptor
  CIPHER_STRATEGY = "aes-256-cbc"

  def self.encrypt(text, iv = nil)
    return "" if text.blank?
    cipher = OpenSSL::Cipher.new(CIPHER_STRATEGY)
    cipher.encrypt
    cipher.key = Base64.decode64(ENV['CIPHER_KEY'])
    iv = iv.present? ? iv : cipher.random_iv
    cipher.iv = iv

    encrypted = cipher.update(text)
    encrypted << cipher.final
    [encrypted, iv]
  end

  def self.decrypt(encrypted, iv)
    return "" if encrypted.blank?
    cipher = OpenSSL::Cipher.new(CIPHER_STRATEGY)
    cipher.decrypt
    cipher.key = Base64.decode64(ENV['CIPHER_KEY'])
    cipher.iv = iv

    decrypted = cipher.update(encrypted)
    decrypted << cipher.final
    decrypted
  end
end
