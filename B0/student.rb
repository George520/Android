#!/usr/bin/ruby -w
class Student
  def initialize() #初始化数据
    #不能通过对象直接访问实例变量,可以通过访问器方法来访问
    @stu_id = "#{$maxId + 1}\n" #使文件里的每一条数据占一行
    @stu_name = "#{[*'a'..'z',*'A'..'Z'].sample(rand(3..8)).join}\n"
    @stu_gender = "#{["man  ","woman"].sample}\n" #man后面有两个空格
    @stu_age = "#{rand(15..20)}\n"
  end

  def getId() #访问器方法,获取的内容有换行符
    @stu_id
  end

  def getName()
    @stu_name
  end

  def getGender()
    @stu_gender
  end

  def getAge()
    @stu_age
  end

  def setId=(value) #设置器方法
    @stu_id = value
  end

  def setName=(value)
    @stu_name = value
  end

  def setGender=(value)
    @stu_gender = value
  end

  def setAge=(value)
    @stu_age = value
  end
end

def loadData(myFile) #加载数据
  (0...$maxId).each do |i|
    @stus[i].setId = myFile.gets
    @stus[i].setName = myFile.gets
    @stus[i].setGender = myFile.gets
    @stus[i].setAge = myFile.gets
  end
end

def showAllData() #显示所有数据
  if $maxId == 0
    puts "无数据"
    return
  end
  i = 0
  puts "序号    年龄     性别    姓名"
  until i >= $maxId do
    if i < 9
      print " #{@stus[i].getId().strip}   "
      print "    #{@stus[i].getAge().strip}   "
      genderPrint(i)
      print "  #{@stus[i].getName()}"
    elsif i >= 9 && i < 99
      print " #{@stus[i].getId().strip}   "
      print "   #{@stus[i].getAge().strip}   "
      genderPrint(i)
      print "  #{@stus[i].getName()}"
    else
      print " #{@stus[i].getId().strip}   "
      print "  #{@stus[i].getAge().strip}   "
      genderPrint(i)
      print "  #{@stus[i].getName()}"
    end
    i += 1
  end
end

def genderPrint(i)
  if @stus[i].getGender().strip.eql?("woman")
    print "   #{@stus[i].getGender().strip} "
  else
    print "   #{@stus[i].getGender().strip}   "
  end
end

def showOneData(i) #显示一条数据
  if i >= $maxId
    puts "无效id"
    return
  end
  puts "序号    年龄     性别    姓名"
  if i < 9
    print " #{@stus[i].getId().strip}   "
    print "    #{@stus[i].getAge().strip}   "
    genderPrint(i)
    print "  #{@stus[i].getName()}"
  elsif i >= 9 && i < 99
    print " #{@stus[i].getId().strip}   "
    print "   #{@stus[i].getAge().strip}   "
    genderPrint(i)
    print "  #{@stus[i].getName()}"
  else
    print " #{@stus[i].getId().strip}   "
    print "  #{@stus[i].getAge().strip}   "
    genderPrint(i)
    print "  #{@stus[i].getName()}"
  end
end

def insertData() #插入数据
  temp = $maxId
  @stus[$maxId] = Student.new() #插入之前要创建一个实例对象,让@stus数组的对象数量加一
  puts "插入第几个？"
  location = gets
  location = location[0,location.length - 1].to_i - 1 #删除换行符
  if location < 0 || location > $maxId
    puts "插入失败\n请输入有效值"
    return
  end
  until $maxId <= location do
    @stus[$maxId].setId = "#{@stus[$maxId - 1].getId().to_i + 1}\n"
    @stus[$maxId].setName = @stus[$maxId - 1].getName()
    @stus[$maxId].setGender = @stus[$maxId - 1].getGender()
    @stus[$maxId].setAge = @stus[$maxId - 1].getAge()
    $maxId -= 1
  end
  @stus[location] = Student.new()
  puts "请输入姓名:"
  name = gets
  puts "请输入性别:"
  gender = gets
  puts "请输入年龄:"
  age = gets
  @stus[location].setName = name
  if gender.strip.eql?("man")
    @stus[location].setGender = "man  \n"
  else
    @stus[location].setGender = gender
  end
  @stus[location].setAge = age
  $maxId = temp + 1
  puts "插入成功"
end

def deleteData() #删除数据
  puts "删除第几个？"
  location = gets
  location = location[0,location.length - 1].to_i - 1
  if location < 0 || location >= $maxId
    puts "删除失败\n请输入有效值"
    return
  end
  (location...$maxId - 1).each do |i|
    @stus[i].setId = "#{@stus[i + 1].getId().to_i - 1}\n"
    @stus[i].setName = @stus[i + 1].getName()
    @stus[i].setGender = @stus[i + 1].getGender()
    @stus[i].setAge = @stus[i + 1].getAge()
  end
  $maxId -= 1
  puts "删除成功"
end

def searchData() #查找数据
  puts "1.根据id查找"
  puts "2.根据姓名查找"
  puts "3.根据性别查找"
  puts "4.根据年龄查找"
    command = gets
    case command.strip
    when "1"
      puts "请输入id:"
      id = gets.strip.to_i - 1
      showOneData(id)
    when "2"
      puts "请输入姓名:"
      name = gets
      flag = true
      for i in 0...$maxId
        if @stus[i].getName().eql?(name)
          showOneData(i)
          flag = false
        end
        next
      end
      if flag == true
        puts "查无此人"
      end
    when "3"
      puts "请输入性别:"
      gender = gets
      i = 0
      while i < $maxId do
        if @stus[i].getGender().strip.eql?(gender.strip) #比较两个字符串的内容和长度是否相等
          showOneData(i)
        end
        i += 1
      end
    when "4"
      puts "请输入年龄:"
      age = gets
      flag = true
      i = 0
      until i >= $maxId do
        if @stus[i].getAge().eql?(age)
          showOneData(i)
          flag = false
        end
        i += 1
      end
      if flag == true
        puts "无此年龄段的人"
      end
    end
end

def modifyData() #修改数据
  puts "请输入要修改的学生的id"
  id = gets.strip.to_i - 1
  if id < 0 || id >= $maxId
    puts "无效id"
    return
  end
  puts "1.修改姓名"
  puts "2.修改性别"
  puts "3.修改年龄"
  choice = gets.strip.to_i
  if choice == 1
    puts "请输入修改后的姓名:"
    name = gets
    @stus[id].setName = name
    puts "修改成功"
  elsif choice == 2 #注意是elsif
    if @stus[id].getGender().strip.eql?("man")
        @stus[id].setGender = "woman\n"
    else
        @stus[id].setGender = "man\n"
    end
    puts "修改成功"
  elsif choice == 3
    puts "请输入修改后的年龄:"
    age = gets
    @stus[id].setAge = age
    puts "修改成功"
  else
    puts "修改失败\n请输入有效值"
  end
end

def sortData() #数据排序
  puts "1.按序号升序"
  puts "2.按序号降序"
  puts "3.按姓名首字母升序"
  puts "4.按姓名首字母降序"
  puts "5.按年龄升序"
  puts "6.按年龄降序"
  command = gets
  case command.strip
  when "1"
    idAscSort()
  when "2"
    idDescSort()
  when "3"
    nameAscSort()
  when "4"
    nameDescSort()
  when "5"
    ageAscSort()
  when "6"
    ageDescSort()
  else
    puts "请输入有效值"
  end
end

def swapData(i,j) #交换两个对象数组的所有值
  temp1 = @stus[j].getId()
  @stus[j].setId = @stus[i].getId()
  @stus[i].setId = temp1

  temp2 = @stus[j].getName()
  @stus[j].setName = @stus[i].getName()
  @stus[i].setName = temp2

  temp3 = @stus[j].getGender()
  @stus[j].setGender = @stus[i].getGender()
  @stus[i].setGender = temp3

  temp4 = @stus[j].getAge()
  @stus[j].setAge = @stus[i].getAge()
  @stus[i].setAge = temp4
end

def idAscSort() #按序号升序
  for i in 0...$maxId - 1
    k = i
    for j in i + 1...$maxId
      if @stus[k].getId().to_i > @stus[j].getId().to_i
          k = j
      end
    end
    if k != i
      swapData(i,k)
    end
  end
end

def idDescSort() #按序号降序
  for i in 0...$maxId - 1
    k = i
    for j in i + 1...$maxId
      if @stus[k].getId().to_i < @stus[j].getId().to_i
          k = j
      end
    end
    if k != i
      swapData(i,k)
    end
  end
end

def nameAscSort() #按姓名首字母升序
  for i in 0...$maxId - 1
    for j in 0...$maxId - i - 1
      name1 = @stus[j].getName().strip.downcase
      name2 = @stus[j + 1].getName().strip.downcase
      minLen = name1.length < name2.length ? name1.length : name2.length
      for k in 0...minLen
        if name1[k] > name2[k]
          swapData(j,j + 1)
          break
        elsif name1[k] == name2[k]
          next
        else
          break
        end
      end
      #较长字符串前几位完全等于较短字符串时
      if k == minLen - 1 && name1.length > name2.length
        swapData(j,j + 1)
      end
    end
  end
end

def nameDescSort() #按姓名首字母降序
  for i in 0...$maxId - 1
    for j in 0...$maxId - i - 1
      name1 = @stus[j].getName().strip.downcase
      name2 = @stus[j + 1].getName().strip.downcase
      minLen = name1.length < name2.length ? name1.length : name2.length
      for k in 0...minLen
        if name1[k] < name2[k]
          swapData(j,j + 1)
          break
        elsif name1[k] == name2[k]
          next
        else
          break
        end
      end
      #较长字符串前几位完全等于较短字符串时
      if k == minLen - 1 && name1.length < name2.length
        swapData(j,j + 1)
      end
    end
  end
end


def ageAscSort() #按年龄升序
  for i in 0...$maxId - 1
    k = i
    for j in i + 1...$maxId
      if @stus[k].getAge().to_i > @stus[j].getAge().to_i
          k = j
      end
    end
    if k != i
      swapData(i,k)
    end
  end
end

def ageDescSort() #按年龄降序
  for i in 0...$maxId - 1
    k = i
    for j in i + 1...$maxId
      if @stus[k].getAge().to_i < @stus[j].getAge().to_i
        k = j
      end
    end
    if k != i
      swapData(i,k)
    end
  end
end

def saveData() #保存数据
  myFile = File.new("student.yml","w")
  for i in 0...$maxId #循环结束后i = $maxId - 1,而不是$maxId
    myFile.syswrite(@stus[i].getId())
    myFile.syswrite(@stus[i].getName())
    myFile.syswrite(@stus[i].getGender())
    myFile.syswrite(@stus[i].getAge())
  end
  myFile.syswrite($maxId) #文件最后一行为学生总人数
  puts "保存成功"
end

$maxId = 0
fileName = "student.yml"
@stus = []
if File.exist?(fileName) #文件存在
  arr = IO.readlines(fileName)
  $maxId = arr[-1].to_i #获取最大id值
  i = 0
  200.times do #容量为两百
    @stus[i] = Student.new()
    i += 1
  end
  myFile = File.new(fileName,"r")
  loadData(myFile)
else
    100.times do
    @stus[$maxId] = Student.new()
    $maxId += 1
  end
  myFile = File.new(fileName,"w")
end
begin
  puts "1.显示数据"
  puts "2.插入数据"
  puts "3.删除数据"
  puts "4.查找数据"
  puts "5.修改数据"
  puts "6.数据排序"
  puts "7.保存数据"
  puts "8.退出系统"
  command = gets
  case command.strip #输入的内容有换行符,strip函数可以删除头部和尾部的空白字符
  when "1"
    showAllData()
  when "2"
    insertData()
  when "3"
    deleteData()
  when "4"
    searchData()
  when "5"
    modifyData()
  when "6"
    sortData()
  when "7"
    saveData()
  when "8"
    puts "下次再见"
    command = "8"
  else
    puts "请输入有效值"
  end
end while command.strip != "8"
