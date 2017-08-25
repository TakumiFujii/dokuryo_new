class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private 
  
  
  
  def require_user_logged_in
    unless logged_in?
      redirect_to root_url
    end
  end
  
  def read(result)
    isbn = result['isbn']
    title = result['title']
    author = result["author"]
    url = result['itemUrl']
    image_url = result['medium_image_url']

    return {
      isbn: isbn,
      title: title,
      author: author,
      url: url,
      image_url: image_url,
    }
  end
  
  def counts(user)
    @willread_count = user.willreads.count
    @done_count = user.dones.count
    @review_count = user.reviews.count
  end
  
end
