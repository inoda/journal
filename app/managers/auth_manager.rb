class AuthManager
  def self.authenticate(username, password)
    user = User.first
    BCrypt::Password.new(user.password) == password && BCrypt::Password.new(user.username) == username
  end
end
