class User < ApplicationRecord
  def password=(value)
    super(BCrypt::Password.create(value))
  end
end
