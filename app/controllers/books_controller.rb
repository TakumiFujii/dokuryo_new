class BooksController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @books = []
    @title = params[:title]
    if @title
      results = RakutenWebService::Books::Book.search({
        title: @title,
        hits: 20
      }) 
      results.each do |result|
        book = Book.find_or_initialize_by(read(result))
        @books << book
      end
    end
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews.all.page(params[:page])
    
  end
  
  private
  
end
