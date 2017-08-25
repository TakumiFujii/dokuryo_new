module DonesHelper
    def done
        @ranking_counts = Done.ranking
        @books = Book.find(@ranking_counts.keys)
    end
end
