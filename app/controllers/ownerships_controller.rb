class OwnershipsController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      @book = Book.new(read(results.first))
      @book.save
    end
    
    if params[:type] == "Willread"
      current_user.willread(@book)
      flash[:success] = "気になるリストに追加しました。"
    end
   
    
    if params[:type] == "Done"
      current_user.done(@book)
      flash[:success] = "読了お疲れ様です、感想をシェアしましょう"
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    
    if params[:type] == "Willread"
      current_user.unwillread(@book)
      flash[:success] = "気になるリストから解除しました"
    end
    
    if params[:type] == "Done"
      current_user.undone(@book)
      flash[:success] = "読了リストから解除しました"
    end
    
    redirect_back(fallback_location: root_path)
  end
end

