class Tag < ApplicationRecord
    has_many :posts, through: :post_tags
  
    validates :name, presence: true, uniqueness: true
  end
  