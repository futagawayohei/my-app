class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @job = current_user.jobs.build  # form_for 用
      @jobs = current_user.jobs.order('created_at DESC').page(params[:page])
      @foods = current_user.foods.build  # form_for 用
      @foods = current_user.foods.order('created_at DESC').page(params[:page])
    end
  end
end
