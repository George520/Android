class FeedbacksController < ApplicationController
  def index
    @feedbacks = Feedback.all.paginate(page: params[:page])
    render layout: 'admin_check'
  end

  def create
    @user = User.find(session[:user_id])
    @feedback = @user.feedbacks.new(feedback_params)
    if @feedback.save
      flash[:notice] = '反馈成功'
    else
      flash[:notice] = '反馈失败'
    end
    redirect_to root_path
  end

  private
  def feedback_params
    params.require(:feedback).permit(:content)
  end
end
