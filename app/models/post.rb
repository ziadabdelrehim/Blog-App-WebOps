class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  after_create :schedule_deletion

  private

  def schedule_deletion
    PostDeletionJob.set(wait: 1.hours).perform_later(self.id)
  end


  validates :title, presence: true
  validates :body, presence: true
  validates :tags, presence: { message: 'must have at least one tag' }

  # Ensure tags are associated correctly
  def tags_presence
    errors.add(:tags, 'must have at least one tag') if tags.empty?
  end
end