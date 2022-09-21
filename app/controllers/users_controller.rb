class UsersController < ApplicationController
  
  
  def index
   @users = User.all
   @user = current_user
   @newbook = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @book = @user.books
    @newbook = Book.new
  end

  def edit
    @user =  User.find(params[:id])
    if @user == current_user
            render :edit
          else
            redirect_to users_path
          end
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
      flash[:success] = "You have updated user successfully."
      redirect_to user_path(@user.id)
   else
    render :edit
   end
  end
  
  def destroy
    @user =  User.find(params[:id])  # データ（レコード）を1件取得
    @user.destroy  # データ（レコード）を削除
    redirect :index  # 投稿一覧画面へリダイレクト  
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :image)  
  end
  
  

end

