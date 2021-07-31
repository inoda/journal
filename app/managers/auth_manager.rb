class AuthManager
  def self.authenticate(username, password)
    user = User.find_by(username: username)
    return false unless user
    BCrypt::Password.new(user.password) == password
  end
end
