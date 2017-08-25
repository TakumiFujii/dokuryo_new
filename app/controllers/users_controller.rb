class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update]
  
  def show
    set_params_thing
    @books = @user.willread_books.order("created_at DESC").page(params[:page])
    counts(@user)
  end
  
  def finished
    set_params_thing
    @done_books = @user.done_books.order("created_at DESC").page(params[:page])
    counts(@user)
  end
  
  def reviews
    set_params_thing
    @reviews = @user.reviews.order("created_at DESC").page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = "登録が完了しました"
      redirect_to root_url
    else
      flash[:success] = "申し訳ありません、登録に失敗しました。"
      render :new
    end
  end

  def profile
    @user = User.find(params[:id])
  end
  
  def profile_update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "変更しました。"
      redirect_to @user
    else
      flash[:danger] = "変更に失敗しました"
      redirect_to @user
    end
  end
  
  def image
    set_params_thing
  end
  
  def image_update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "変更しました。"
      redirect_to @user
    else
      flash[:danger] = "変更に失敗しました"
      redirect_to @user
    end
  end
  
  
  def email
    set_params_thing
  end
  
  def email_update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "変更しました。"
      redirect_to @user
    else
      flash[:danger] = "変更に失敗しました"
      redirect_to @user
    end
  end
  
  def password
    set_params_thing
  end

  def password_update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "変更しました。"
      redirect_to @user
    else
      flash[:danger] = "変更に失敗しました"
      redirect_to @user
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:nickname, :email, :gender, :password, :password_confirmation, :image)
  end
  
  def set_params_thing
    @user = User.find(params[:id])
  end
end
