class CommentsController < ApplicationController
  before_action :require_user_login, only:[:create]
  before_action :require_admin_login, only:[:index]

  def index
    @comments = Comment.where.not(comment_check: true).paginate(page: params[:page])
    render layout: 'admin_check'
  end

  def check
    @comment = Comment.find(params[:comment][:id])
    if params[:comment][:check] == "true"
      @comment.comment_check = true
    else
      @comment.comment_check = false
    end
    if @comment.save
      redirect_to comments_path
    end
  end

  def create
    if session[:user_id]
      @comment = Comment.create(comment_params)
      redirect_back(fallback_location: root_path)
    else
      redirect_to user_login_path
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :message, :comment_check, :commentable_id, :commentable_type)
  end

  def require_admin_login
    unless session[:admin_id]
      redirect_to admin_login_path
    end
  end

  def require_user_login
    unless session[:user_id]
      redirect_to user_login_path
    end
  end
end
