# 一.数据结构
## 1.管理员账户表admins

| 字段名 | 类型 | 描述 | 字段约束 |
| :-: | :-: | :-: | :-: |
| id | int | 管理员ID | 无 |
| admin_name | string | 用户名 | 非空,唯一性,长度范围:[3,20] |
| password | string | 密码 | 非空,只允许用以下字符:a-z,0-9,!@#$%^&*() |

主键：id <br>
外键：无 <br>
索引：id <br>
关联表：has_many :posts <br>

## 2.用户表users

| 字段名 | 类型 | 描述 | 字段约束 |
| :-: | :-: | :-: | :-: |
| id | int | 用户ID | 无 |
| username | string | 用户名 | 非空,唯一性,长度范围:[3,20] |
| Email | string | 邮件地址 | 符合格式xxx@xxx.com的要求 |
| password | string | 密码 | 非空,只允许用以下字符:a-z,0-9,!@#$%^&*() |

主键：id <br>
外键：无 <br>
索引：id <br>
关联表：has_many :posts, comments, feedbacks <br>

## 3.文章表posts

| 字段名 | 类型 | 描述 | 字段约束 |
| :-: | :-: | :-: | :-: |
| id | int | 文章ID | 无 |
| user_id | int | 用户ID | 无 |
| admin_id | int | 管理员ID | 无 |
| title | string | 文章题目 | 长度不小于3 |
| body | text | 文章内容 | 长度不小于100 |
| post_check | int | 文章审核 | 值为0或1 |
| created_at | date | 创建日期 | 无 |

主键：id <br>
外键：admin_id, user_id <br>
索引：id <br>
关联表：has_many :comments <br>
&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;belongs_to :admins, users <br>

## 4.留言表comments

| 字段名 | 类型 | 描述 | 字段约束 |
| :-: | :-: | :-: | :-: |
| id | string | 留言ID | 无 |
| user_id | int | 用户ID | 无 |
| post_id | int | 文章ID | 无 |
| messsage | text | 留言内容 | 长度不小于3 |
| comment_check | int | 留言审核 | 值为0或1 |
| created_at | date | 创建日期 | 无 |

主键：id <br>
外键：post_id, user_id <br>
索引：id <br>
关联表：belongs_to :posts, users <br>

## 5.反馈表feedbacks

| 字段名 | 类型 | 描述 | 字段约束 |
| :-: | :-: | :-: | :-: |
| id | int | 反馈ID | 无 |
| user_id | int | 用户ID | 无 |
| content | text | 反馈内容 | 长度不小于5 |

主键：id <br>
外键：user_id <br>
索引：id <br>
关联表：belongs_to :user <br>


