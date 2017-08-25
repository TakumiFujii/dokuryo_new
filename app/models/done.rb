class Done < Ownership
    def self.ranking
        self.group(:book_id).order("count_book_id DESC").limit(5).count(:book_id)
    end
end
