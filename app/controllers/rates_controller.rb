class RatesController < ApplicationController
  before_action :logged_in_user
  before_action :load_book, only: :create
  before_action :load_book_rating, only: :update

  def create
    unless current_user.rate @book, params[:num_rate]
      flash[:warning] = t "app.controllers.rate.error_save"
      redirect_to root_url
    end
    redirect_to book_path @book
  end

  def update
    unless current_user.re_rate @book, params[:num_rate]
      flash[:warning] = t "app.controllers.rate.error_update"
      redirect_to root_url
    end
    redirect_to book_path @book
  end

  private
  def load_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:warning] = t "app.controllers.books.not_found"
      redirect_to root_url
    end
  end

  def load_book_rating
    @rate = Rating.find_by id: params[:id]
    @book = @rate.book if @rate
    unless @book
      flash[:warning] = t "app.controllers.books.not_found"
      redirect_to root_url
    end
  end
end
