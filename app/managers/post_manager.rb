class PostManager
  def self.create(title, content, tags)
    post = Post.new(title: title, content: content)

    tags.each do |t|
      tag = Tag.find_by_label(Tag.encrypted_label(t))
      tag = Tag.create(label: t) if tag.nil?
      post.tags << tag
    end

    post.save
    post
  end

  def self.update(post, title, content, tags)
    post.post_tags.destroy_all

    tags.each do |t|
      tag = Tag.find_by_label(Tag.encrypted_label(t))
      tag = Tag.create(label: t) if tag.nil?
      post.tags << tag
    end

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
