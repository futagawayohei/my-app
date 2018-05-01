class JobsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
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

  def destroy
    @job.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
    private

  def job_params
    params.require(:job).permit(:content)
  end

  def correct_user
    @job = current_user.jobs.find_by(id: params[:id])
    unless @job
      redirect_to root_url
    end
  end
end
