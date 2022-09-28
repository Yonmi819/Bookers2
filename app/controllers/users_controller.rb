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
    @book_comment = BookComment.new
  end

  def edit
   @user =  User.find(params[:id])
    unless @user == current_user
    redirect_to user_path(current_user.id)
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
  
  def follows
  user = User.find(params[:id])
  @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
  user = User.find(params[:id])
  @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :image)  
  end
  
  

end

