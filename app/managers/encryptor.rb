class Encryptor
  def self.encrypt(text, iv = nil)
    return "" if text.blank?
    cipher = OpenSSL::Cipher.new("aes-256-cbc")
    cipher.encrypt
    cipher.key = ENV['CIPHER_KEY']
    iv = iv.present? ? iv : cipher.random_iv
    cipher.iv = iv

    encrypted = cipher.update(text)
    encrypted << cipher.final
    [encrypted, iv]
  end

  def self.decrypt(encrypted, iv)
    return "" if encrypted.blank?
    cipher = OpenSSL::Cipher.new("aes-256-cbc")
    cipher.decrypt
    cipher.key = ENV['CIPHER_KEY']
    cipher.iv = iv

    decrypted = cipher.update(encrypted)
    decrypted << cipher.final
    decrypted
  end
end
