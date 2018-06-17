# Clearist
参考项目：番茄土豆 & 滴答清单

基于ASP.NET、SQL Server
***
## Cookie对象
* id: 用户的ID
* uid: 用户的UID
* mission_count: 用户的任务数
* detailed: 用来记录当前鼠标选择到的任务id，初始值为0表示未选择任何任务
* mission_delete: 用来记录当前删除的任务id，默认值为0表示未删除任何任务（改变值的这一过程无法看到）
* mission_selected: 用来记录当前勾选已完成（划掉）的任务，默认值为空表示未勾选任何任务





## account表

#### 用来记录用户的账户信息

* id: 记录用户名，可以为中文和英文，不可重复
* psw: 记录用户的密码
* uid(主键): 作为用户的唯一标识
> 用 IDENTITY(1000,1) 设置为自1000开始的自动填充字段






## mission表

#### 用来记录用户所记录的任务

* uid: 记录者的uid
* mission: 记录任务的名字
* start_time: 任务开始时间（默认为建立任务的时间）**[默认/手动添加]**
> Default约束，默认值为当前系统时间
>
> 		alter table mission
> 		add constraint defalut_start_time default(getdate()) for start_time

* time_consuming: 任务耗时 **[默认]**
> Default约束，默认时间为00:00:00.000000
>
> 		alter table mission
> 		add constraint defalut_time_consuming default('00:00:00') for time_consuming

* complete_time: 完成时间 **[允许NULL]**
* note: 笔记 **[允许NULL]**
* mark: 标记任务是否完成 **[默认]**
> Default约束，默认为“1”
>
> 		alter table mission
> 		add constraint defalut_mark default(1) for mark

* mission_id(主键): 任务id **[默认]**

> 测试插入数据：
>
>		insert into mission (uid,mission) values('1000','这是一个uid为1000的用户创建的一个项目')





## subtasks表

### 用来记录子任务
> 创建脚本
>
>		CREATE TABLE subtasks  
>		(  
>			mission_id int,
>			subtasks nvarchar(50),
>			subtasks_id int IDENTITY(1,1)
>		)

* mission_id: 该条子任务属于的主任务id
* subtasks: 子任务内容
* subtasks_id: 子任务id






## 带参存储过程


* add_mission: 新建任务时执行的存储过程
> 创建语句：
>
>		Create proc add_mission @uid int, @mission nvarchar(50), @note nvarchar(max)
>		As
>		Begin
>			insert into mission (uid, mission, note)
>			values (@uid, @mission, @note)
>		End
>
> 测试插入：
>
>		exec add_mission '1000', '数据库插入测试', '美妙绝伦！'

* add_subtasks: 创建子任务时执行的存储过程
> 创建语句:
>
>		Create proc add_subtasks @mission_id int, @subtasks nvarchar(50)
>		As
>			Begin
>			insert into subtasks (mission_id, subtasks)
>			values (@mission_id, @subtasks)
>		End
>
> 测试插入
> 
>		exec add_subtasks '1078', '子任务'

* alter_mission: 更改任务信息
> 创建语句:
>
>		Create proc alter_mission @mission_id int, @mission nvarchar(50), @note nvarchar(max)
>		As
>		Begin
>			update mission set mission = @mission where mission_id = @mission_id
>			update mission set note = @note where mission_id = @mission_id
>		End
> 测试更改：
>
>		exec alter_mission '1000','更改的任务名字','更改的任务备注'




## 触发器
* 在删除主任务时，清除该任务对应的子任务

***

## 后台执行的SQL语句

###trash.aspx.cs：
* 删除任务
>	Delete From mission Where mission_id = 任务ID

* 还原任务
>	update mission Set mark = 1 Where mission_id = 任务ID





