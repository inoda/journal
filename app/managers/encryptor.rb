class Encryptor
  def self.encrypt(text)
    cipher = OpenSSL::Cipher.new("aes-256-cbc")
    cipher.encrypt
    cipher.key = ENV['CIPHER_KEY']
    iv = cipher.random_iv
    cipher.iv = iv

    encrypted = cipher.update(text)
    encrypted << cipher.final
    [encrypted, iv]
  end

  def self.decrypt(encrypted, iv)
    cipher = OpenSSL::Cipher.new("aes-256-cbc")
    cipher.decrypt
    puts ENV['CIPHER_KEY']
    cipher.key = ENV['CIPHER_KEY']
    cipher.iv = iv

    decrypted = cipher.update(encrypted)
    decrypted << cipher.final
    decrypted
  end
end
