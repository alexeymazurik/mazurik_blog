class Post < ActiveRecord::Base
  acts_as_taggable_on :tags
  belongs_to :user
  belongs_to :section

  validates :title, presence: true, length: 1..255
end
