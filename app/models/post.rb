class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
  belongs_to :user
  belongs_to :section
  has_many :likes

  validates :title, presence: true, length: 1..255

  def like(user)
    likes << Like.new(user: user)
  end
  def unlike(user)
    likes.where(user_id: user.id).first.destroy
  end

  def already_liked?(user)
    !Like.where(post_id: self.id).where(user_id: user.id).empty?
  end

  def likes_count
    Like.where(post_id: self.id).count
  end
end
