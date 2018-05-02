class JobsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @jobs = current_user.jobs.all
  end
  
  def show
    @job = Job.find(params[:id])
  end
  
  def new
    @job = Job.new
  end
  
  
  def create
    @job = current_user.jobs.build(job_params)
    if @job.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @jobs = current_user.jobs.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
    @job = Job.find(params[:id])
  end

  def update
    if @job.update(job_params)
      flash[:success] = 'メニュー は正常に更新されました'
      redirect_to @job
    else
      flash.now[:danger] = 'メニュー は更新されませんでした'
      render :edit
    end
  end
  

  def destroy
    @job.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
    private

  def job_params
    params.require(:job).permit(:burn_at,:content,:calorie)
  end

  def correct_user
    @job = current_user.jobs.find_by(id: params[:id])
    unless @job
      redirect_to root_url
    end
  end
end
