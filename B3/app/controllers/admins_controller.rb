class AdminsController < ApplicationController
  layout 'user_admin', except: [:my_check, :check, :check_show, :check_index]
  before_action :require_login, except: [:register, :create, :new, :login]

  def my_check
    @posts = Post.where(admin_id: session[:admin_id]).paginate(page: params[:page])
    @admin_name = Admin.find(session[:admin_id]).admin_name
    render layout: 'admin_check'
  end

  def check
    @post = Post.find(params[:admin][:post_id])
    if params[:admin][:post_check] == "true" # params的内容是字符串
      @post.post_check = true
    else
      @post.post_check = false
    end
    if @post.save
      @post.update(admin_id: session[:admin_id])
      redirect_to check_index_path
    else
      render 'check_show'
    end
  end

  def check_show
    @post = Post.find(params[:post_id])
    render layout: 'admin_check'
  end

  def check_index
    @posts = Post.where.not(post_check: true).paginate(page: params[:page])
    render layout: 'admin_check'
  end

# get 'admins/register'
  def register
    @notice = flash[:notice]
    flash[:notice] = nil
    render 'register'
  end

# post 'admins/register'
  def create
    @admin = Admin.new(admin_params)
    @admin.count = 0
    if @admin.save
      session[:admin_id] = @admin.id
      redirect_to check_posts_path
    else
      flash[:notice] = "注册失败"
      redirect_to admin_register_path
    end
  end
# get 'admins/login'
  def new
    if $count == 3
      scheduler = Rufus::Scheduler.new
      scheduler.in '5s' do
        $count = 0
        Admin.find(session[:admin_id]).update(:count => 0)
      end
      redirect_to admin_lock_path
    else
      @notice = flash[:notice]
      flash[:notice] = nil
      render 'login'
    end
  end

  def lock
    @notice = "您的账户已被锁定，请十分钟后再试"
  end

# post 'admins/login'
  def login
    @admin = Admin.find_by(admin_name: params[:admin][:admin_name])
    if @admin && @admin.authenticate(params[:admin][:password])
      session[:admin_id] = @admin.id
      redirect_to check_index_path
    else
      if @admin
        if @admin.count == 0
          session[:admin_id] = @admin.id
          $count = 0
          @admin.update(:count => 1)
        end
        $count = $count.to_i + 1
        flash[:notice] = "用户名或密码错误"
      else
        flash[:notice] = "用户名不存在"
      end
      redirect_to admin_login_path
    end
  end

  def destroy
    session[:admin_id] = nil
  end

  private
  def admin_params
    params.require(:admin).permit(:admin_name, :password, :count)
  end

  def require_login
    unless session[:admin_id]
      redirect_to admin_login_path
    end
  end
end
