require 'sinatra'
require 'time'
class Message
  def initialize()
    @id = 0
    @message = ''
    @author = ''
    @create_at = Time.now
  end

  def setId=(value)
    @id = value
  end

  def setMessage=(value)
    @message = value
  end

  def setAuthor=(value)
    @author = value
  end

  def setTime=(value)
    @create_at = value
  end

  def getId
    @id
  end

  def getMessage
    @message
  end

  def getAuthor
    @author
  end

  def getTime
    @create_at
  end
end

def loadData(msgFile) # 加载数据
  (0...$maxId).each do |i|
    j = 0
    @user[i].setId = msgFile.gets
    @user[i].setMessage = msgFile.gets
    @user[i].setAuthor = msgFile.gets
    @user[i].setTime = msgFile.gets
  end
end

def saveData() # 保存数据
  myFile = File.new("message.txt","w")
  for i in (0...$maxId)
    myFile.syswrite(@user[i].getId)
    myFile.syswrite(@user[i].getMessage)
    myFile.syswrite(@user[i].getAuthor)
    myFile.syswrite(@user[i].getTime)
  end
  myFile.syswrite($maxId)
end

def insert(author,message) # 插入数据
  @user[$maxId] = Message.new()
  @user[$maxId].setId = "#{$maxId + 1}\n"
  @user[$maxId].setMessage = "#{message}\n"
  @user[$maxId].setAuthor = "#{author}\n"
  @user[$maxId].setTime = "#{@user[$maxId].getTime}\n"
  $maxId += 1
  saveData()
end

def swap(i,j) # 交换数据
  temp1 = @user[j].getId
  @user[j].setId = @user[i].getId
  @user[i].setId = temp1

  temp2 = @user[j].getMessage
  @user[j].setMessage = @user[i].getMessage
  @user[i].setMessage = temp2

  temp3 = @user[j].getAuthor
  @user[j].setAuthor = @user[i].getAuthor
  @user[i].setAuthor = temp3

  temp4 = @user[j].getTime
  @user[j].setTime = @user[i].getTime
  @user[i].setTime = temp4
end

def idAscSort() # 按照id升序
  for i in 0...$maxId - 1
    k = i
    for j in i + 1...$maxId
      if @user[k].getId.to_i > @user[j].getId.to_i
        k = j
      end
      if k != i
        swap(i,k)
      end
    end
  end
end

def idDescSort() # 按照id降序
  for i in 0...$maxId - 1
    k = i
    for j in i + 1...$maxId
      if @user[k].getId.to_i < @user[j].getId.to_i
        k = j
      end
      if k != i
        swap(i,k)
      end
    end
  end
end

def timeDescSort() # 时间倒序
  for i in 0...$maxId - 1
    k = i
    for j in i + 1...$maxId
      time_k = Time.parse(@user[k].getTime)
      time_j = Time.parse(@user[j].getTime)
      if time_k.year < time_j.year
        k = j
      elsif time_k.year == time_j.year
        if time_k.month < time_j.month
          k = j
        elsif time_k.month == time_j.month
          if time_k.day < time_j.day
              k = j
          elsif time_k.day == time_j.day
            if time_k.hour < time_j.hour
                k = j
            elsif time_k.hour == time_j.hour
              if time_k.min < time_j.min
                  k = j
              elsif time_k.min == time_j.min
                if time_k.sec < time_j.sec
                    k = j
                end
              end
            end
          end
        end
      end
    end
  if k != i
    swap(i,k)
  end
  end
end

get '/' do
  @user = []
  fileName = "message.txt"
  if File.exist?(fileName) # 文件存在
    arr = IO.readlines(fileName)
    $maxId = arr[-1].to_i # 文件最后一行为最大id
    (0...$maxId).each do |i|
      @user[i] = Message.new()
      i += 1
    end
    myFile = File.new(fileName,"r")
    loadData(myFile)
    timeDescSort() # 时间倒序
  else # 文件不存在
    $maxId = 0
    myFile = File.new(fileName,"w")
  end
  @id = params['id'] # 通过id查询
  @author = params['author'] # 通过作者查询
  add_Author = params['add_Author'] # 添加的作者
  add_Message = params['add_Message'] # 添加的信息
  editId = params['editId'] # 编辑的id
  editMessage = params['editMessage'] # 编辑的消息
  if !add_Author.to_s.empty? && add_Message.to_s.length >= 10 # 作者不为空，长度不小于10则添加
    insert(add_Author,add_Message.to_s)
  end
  temp = 0
  if !editMessage.to_s.empty? && editId.to_i > 0 && editId.to_i <= $maxId # 编辑
    (0...$maxId).each do |j|
      if @user[j].getId.to_i == editId.to_i
        temp = j
        break
      end
    end
    @user[temp].setMessage = "#{editMessage}\n"
    saveData()
  end
  erb :home
end

get '/add' do # 添加
  erb :add
end

get '/delete/:id' do #删除
  @user = []
  fileName = "message.txt"
  if File.exist?(fileName)
    arr = IO.readlines(fileName)
    $maxId = arr[-1].to_i
    (0...$maxId).each do |i|
      @user[i] = Message.new()
      i += 1
    end
    myFile = File.new(fileName,"r")
    loadData(myFile)
  end
  @num = params['id']
  erb :delete
end
