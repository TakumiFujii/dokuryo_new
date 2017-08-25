class User < ApplicationRecord
    validates :nickname, presence: true, length: { maximum: 50 }
    validates :gender, presence: true
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                      uniqueness: { case_sensitive: false }
    
    def set_image(file)
        if !file.nil?
          file_name = file.original_filename
          File.open("public/user_images/#{file_name}", 'wb') { |f|
            f.write(file.read)
          }
          self.image = file_name
        end
    end
    
    mount_uploader :image, ImageUploader
  
    has_secure_password
    
    has_many :ownerships
    has_many :books, through: :ownerships
    
    has_many :willreads
    has_many :willread_books, through: :willreads, class_name: "Book", source: :book
    
    has_many :dones
    has_many :done_books, through: :dones, class_name: :"Book", source: :book
    
    has_many :reviews
    
    def willread(book)
      self.willreads.find_or_create_by(book_id: book.id)
    end
    
    def unwillread(book)
      willread = self.willreads.find_by(book_id: book.id)
      willread.destroy if willread
    end
    
    def willreadyet?(book)
      self.willread_books.include?(book)
    end
    
    def done(book)
      self.dones.find_or_create_by(book_id: book.id)
    end
    
    def undone(book)
      done = self.dones.find_by(book_id: book.id)
      done.destroy if done
    end
    
    def doneyet?(book)
      self.done_books.include?(book)
    end
end
