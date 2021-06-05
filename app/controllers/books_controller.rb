class BooksController < ApplicationController
    before_action :authenticate_user!
    before_action :correct_books,only: [:edit]
  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @new_book = Book.new
    @user = @book.user
  end

  def index
    @book = Book.new
    @user = current_user
    @books = Book.all
    @books = Book.joins(:favorites).group(:book_id).order('count(book_id) desc')

  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_books
        @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
