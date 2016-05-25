class Section < ActiveRecord::Base
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: 1..255
end
