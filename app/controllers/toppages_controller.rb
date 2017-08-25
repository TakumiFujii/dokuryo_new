class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @reviews = current_user.reviews.order('created_at DESC').page(params[:page])
      
      @review = current_user.reviews.build #form_forのやつ

      # 自分以外の直近5件の Done リストを降順で取得する
      # 思ってたよりめっちゃ単純やった、、、
      @dones = Done.where.not(user_id: current_user.id).order('id DESC').limit(5)
      @reviews = Review.order("id DESC").limit(5)
      
      @done_ranking_counts = Done.ranking
      @books = Book.find(@done_ranking_counts.keys)
      
    end
  end
end