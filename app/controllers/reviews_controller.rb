class ReviewsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :update]
  before_action :correct_book, only: [:new]
  
  def new
    @review = current_user.reviews.build(book_id: params[:book_id])
    # @book = Book.find(params[:book_id])
    # correct_bookで確認、取得してるから、いらへん。
  end
  
  def show
    @review = Review.find(params[:id])
    @user = User.find_by(id: @review.user_id)
    @book = Book.find_by(id: @review.book_id)
  end
  
  def create
    @review = current_user.reviews.new(review_params)
      if @review.save
        flash[:success] = "レビューが投稿されました"
        redirect_to root_url
      else 
        flash[:danger] = "レビューの投稿に失敗しました"
        redirect_to root_url
      end
  end
  
  def edit
    @review = Review.find(params[:id])
    @book = @review.book
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    flash[:success] = "レビューの内容を編集しました"
    redirect_to root_url
  end

  def destroy
    @review.destroy
    flash[:success] = "レビューを削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def correct_user
    @review = current_user.reviews.find_by(id: params[:id])
      unless @review
        redirect_to root_url
      end
  end
  
  def correct_book
    @book = current_user.done_books.find_by(id: params[:book_id])
      unless @book
        redirect_to root_url 
      end
  end
  
  def review_params
    params.require(:review).permit(:title, :rate, :content, :book_id)
  end
end
