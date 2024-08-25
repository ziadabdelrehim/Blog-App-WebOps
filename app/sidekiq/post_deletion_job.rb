class PostDeletionJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find_by(id: post_id)
    post.destroy if post && post.created_at < 1.hours.ago
  end
end