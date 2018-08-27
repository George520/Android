class UsersController < ApplicationController
  layout 'user_admin', except: [:personal_page]
  def personal_page
    if session[:user_id]
      @posts = Post.where(user_id: session[:user_id]).paginate(page: params[:page])
      @username = User.find(session[:user_id]).username
    else
      redirect_to user_login_path
    end
  end

# get 'users/register'
  def register
    @notice = flash[:notice]
    flash[:notice] = nil
    render 'register'
  end

# post 'users/register'
  def create
    # 必须设置健壮参数
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:username] = @user.username
      redirect_to root_path
    else
      flash[:notice] = "注册失败"
      redirect_to user_register_path
    end
  end

# get 'users/login'
  def new
    @notice = flash[:notice]
    flash[:notice] = nil
    render 'login'
  end

# post 'users/login'
  def login
    @user = User.find_by(username: params[:user][:username]) #不能去掉:user
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      session[:username] = @user.username
      redirect_to root_path
    else
      flash[:notice] = "用户名或密码错误"
      redirect_to user_login_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
