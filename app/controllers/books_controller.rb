class BooksController < ApplicationController

  def show
    @book=Book.new
    @bookfind = Book.find(params[:id])
    @book_comment=BookComment.new
    @book_comments=@book.book_comments
    @user=User.find(@bookfind.user.id)
  end

  def index
    @book=Book.new
    if params[:star_count]
      @books=Book.star_count
    elsif params[:newbook]
      @books=Book.newbook
    else
      @books=Book.all
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if(@book.user_id!=current_user.id)
      redirect_to books_path
    end
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

  def search_book
    @book=Book.new
    @books=Book.search(params[:keyword])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :confort, :category)
  end
end
