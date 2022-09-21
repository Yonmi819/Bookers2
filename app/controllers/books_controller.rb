class BooksController < ApplicationController
  
  
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
     @user = current_user
  end
  
  def edit
     @book = Book.find(params[:id])
     if @book == current_user
            render :edit
          else
            redirect_to books_path
          end
  end
  
  def update
     @book = Book.find(params[:id])
   if @book.update(book_params)
     flash[:success] = 'You have updated book successfully.'
     redirect_to book_path(@book.id)
   else
     render :edit
   end
  end
  
  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to books_path  # 投稿一覧画面へリダイレクト  
  end
  
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
  

end
