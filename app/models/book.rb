class Book < ApplicationRecord
    validates :isbn, presence: true, length: { maximum: 255 }
    validates :title, presence: true, length: { maximum: 255}
    validates :author, presence: true, length: {maximum: 255}
    validates :url, presence: true, length: { maximum: 255}
    validates :image_url, presence: true, length: { maximum: 255}
    
    has_many :ownerships
    has_many :books, through: :ownerships
    
    has_many :willreads
    has_many :willread_users, through: :willreads, class_name: "User", source: :user
    
    has_many :dones
    has_many :done_users, through: :dones, class_name: "User", source: :user
    
    has_many :reviews
    
    def average_rate
        rate = self.reviews.where.not.(rate: nil).average(:rate)
        return rate
    end
end