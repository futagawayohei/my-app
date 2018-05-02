class FoodsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @foods = current_user.foods.all
  end
  
  def show
    @food = Food.find(params[:id])
  end
  
  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      flash[:success] = 'メニューを投稿しました。'
      redirect_to root_url
    else
      @foods = current_user.foods.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メニューの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
    @food = Food.find(params[:id])
  end

  def update
    if @food.update(food_params)
      flash[:success] = 'メニュー は正常に更新されました'
      redirect_to @food
    else
      flash.now[:danger] = 'メニュー は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @food.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def food_params
    params.require(:food).permit(:ate_at,:content,:fat)
  end

  def correct_user
    @food = current_user.foods.find_by(id: params[:id])
    unless @food
      redirect_to root_url
    end
  end
end
