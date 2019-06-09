class PostManager
  def self.create(title, content, tags)
    post = Post.new(title: title, content: content)
    tags.each { |tag| post.tags << Tag.find_or_create_by(label: tag) }
    post.save
    post
  end

  def self.update(post, title, content, tags)
    post.post_tags.destroy_all
    tags.each { |tag| post.tags << Tag.find_or_create_by(label: tag) }
    post.update(title: title, content: content)
  end
end
