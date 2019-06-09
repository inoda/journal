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
end
