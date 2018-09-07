class PostsController < ApplicationController
  before_action :validate_search_key, only: [:search]
  before_action :require_login, only:[:new]
  def time
    @posts = Post.where(month: params[:month],post_check: true).paginate(page: params[:page])
  end

  def category
    @category = params[:name]
    @posts = Post.where(categories: @category, post_check: true).paginate(page: params[:page])
  end

  def index
    if session[:user_id]
      @username = User.find(session[:user_id]).username
    end
    @posts = Post.where(:post_check => true).paginate(page: params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.where(comment_check: true)
  end

  def new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.postable_id = session[:user_id]
    @post.postable_type = "User"
    if @post.save
      @post.update(month: @post.created_at.month)
      # 重定向到show页面
      redirect_to @post
    else
      redirect_to user_login_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      # 重定向到show页面
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    if @query_string.present?
       search_result = Post.ransack(@search_criteria).result(:distinct => true)
       @posts = search_result.paginate(:page => params[:page], :per_page => 5 )
    end
  end

  private
  def post_params
    params.require(:post).permit(:admin_id, :user_id, :title, :body, :categories, :post_check, :postable_id, :postable_type)
  end

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { title_cont: query_string }
  end

  def require_login
    unless session[:user_id]
      redirect_to user_login_path
    end
  end
end
