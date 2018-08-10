require 'sinatra'
require 'sinatra/activerecord' # 可能需要下载
require 'bcrypt'
require './models/message'
require './models/user'
require 'pry'
enable :sessions

get '/' do
  if session['id']
    @user = User.find(session['id']) # 只能通过id查找
    @users = User.all
    @messages = Message.all
    erb :index
  else
    redirect '/login'
  end
end

get '/home' do
  @user_id = session['id']
  erb :home
end

get '/signup' do
  @notice = session['notice']
  session['notice'] = nil # 必须置空
  erb :signup
end

post '/signup' do
  @user = User.new(username: params["username"],password: params["password"])
  if @user.save
    session['id'] = @user.id
    redirect '/'
  else
    session['notice'] = "Invalid username or password"
    redirect '/signup'
  end
end

get '/login' do
  @notice = session['notice']
  session['notice'] = nil
  erb :login
end

post '/login' do
  @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session['id'] = @user.id
    redirect '/'
  else
    session['notice'] = "Incorrect username or password"
    redirect '/login'
  end
end

get '/logout' do
  session['id'] = nil
  redirect '/login'
end

get '/add' do
  @notice = session['notice']
  session['notice'] = nil
  erb :add
end

post '/add' do
  @message = Message.new(user_id: session['id'], content: params[:content])
  if @message.save
    redirect '/'
  else
    session['notice'] = "Faild to add message"
    redirect '/add'
  end
end

get '/delete/:id' do
  @notice = session['notice']
  session['notice'] = nil
  erb :delete
end
post '/delete/:id' do
  if Message.find(params['id']).destroy
    redirect '/home'
  else
    session['notice'] = "Failed to delete message"
    redirect '/delete/:id'
  end
end

get '/search' do
  @notice = session['notice']
  session['notice'] = nil
  @user_id = session['user_id']
  # session['user_id']不必置空，否则在/search页面下刷新页面无法响应
  erb :search
end

post '/search' do
  @user = User.find_by(id: params[:user_id], username: params[:username])
  @user_id = User.find_by(id: params[:user_id])
  @username = User.find_by(username: params[:username])
  if @user || (@user_id && !@username)
    session['user_id'] = params[:user_id]
  elsif !@user_id && @username
    User.all.each do |user|
      if user.username.to_s == params[:username].to_s
        session['user_id'] = user.id
        break
      end
    end
  else
    session['notice'] = "Invalid user_id or username"
  end
  redirect '/search'
end

get '/edit/:id' do
  @message_id = params['id']
  @notice = session['notice']
  session['notice'] = nil
  erb :edit
end

post '/edit/:id' do
  if Message.find(params['id']).update(content: params[:content])
    redirect '/home'
  else
    session['notice'] = "Invalid content"
    redirect '/edit/:id'
  end
end

get '/username' do
  @notice = session['notice']
  session['notice'] = nil
  erb :modify_username
end

post '/username' do
  @user_id = session['id']
  if User.find(@user_id).update(username: params[:username])
    session['notice']
  else
    session['notice'] = "Failed to modify usrename"
  end
  redirect '/username'
end

get '/password' do
  @notice = session['notice']
  session['notice'] = nil # 必须置空，否则在一次会议内只能修改一次密码
  erb :modify_password
end

post '/password' do
  @user_id = session['id']
  if User.find(@user_id).password == params[:password1]
    if params[:password2] == params[:password3]
      session['notice'] = "Success"
      User.find(@user_id).update(password: params[:password2])
    else
      session['notice'] = "The passsword you input twice isn't equal"
    end
  else
    session['notice'] = "Incorrect password"
  end
  redirect '/password'
end
