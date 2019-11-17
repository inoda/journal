class PostManager
  def self.create(title, content)
    post = Post.new(title: title, content: content)
    post.save
    post
  end

  def self.update(post, title, content)
    post.update(title: title, content: content)
  end

  def self.share(post, public)
    sharing_token = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Post.exists?(sharing_token: Post.encrypted_sharing_token(random_token))
    end

    post.update(sharing_token: sharing_token, listed_publicly: public)
  end

  def self.unshare(post)
    post.update(sharing_token: nil, listed_publicly: false)
  end
end
