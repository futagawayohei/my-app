class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @jobs = @user.jobs.order('created_at DESC').page(params[:page])
    counts(@user)
    
    @user = User.find(params[:id])
    @foods = @user.foods.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
   private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end