class Review < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000 }
  validates :rate, presence: true
  validates :user_id, presence: true
  validates :book_id, presence: true
  
  belongs_to :user
  belongs_to :book
end
