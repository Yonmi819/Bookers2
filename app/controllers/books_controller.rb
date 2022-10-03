class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end
 
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
     flash[:success] = 'You have created book successfully.'
    redirect_to book_path(@book.id)
   else
     @user = current_user
     @books = Book.all
     render :index
   end
  end
  
  def index
     @books = Book.all
     @book = Book.new
     @user = current_user
     
  end
  
  def show
     @book = Book.find(params[:id])
     @newbook = Book.new
     @user =  @book.user
     @book_comment = BookComment.new
     @favorite = Favorite.new
  end
  
  def edit
   @book = Book.find(params[:id])
    unless @book.user == current_user
     redirect_to books_path
    end
  end
  
  def update
     @book = Book.find(params[:id])
   if @book.update(book_params)
     flash[:success] = 'You have updated book successfully.'
     redirect_to book_path(@book.id)
   else
     flash.now[:danger] = "error prohibited this obj from being saved: " 
        @books = Book.all
     render :edit
   end
  end
  
  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path  # 投稿一覧画面へリダイレクト  
  end
  
  private

 def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
 end    

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  
end
