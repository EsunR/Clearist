# Clearist
参考项目：番茄土豆 & 滴答清单

基于ASP.NET、SQL Server
***
## Cookie对象
* id: 用户的ID
* uid: 用户的UID
* mission_count: 用户的任务数

## 数据库构成

### account表

**用来记录用户的账户信息**

* id: 记录用户名，可以为中文和英文，不可重复
* psw: 记录用户的密码
* uid(主键): 作为用户的唯一标识
> 用 IDENTITY(1000,1) 设置为自1000开始的自动填充字段

### mission表

**用来记录用户所记录的任务**

* uid: 记录者的uid
* mission: 记录任务的名字
* start_time: 任务开始时间（默认为建立任务的时间）**[默认/手动添加]**
> Default约束，默认值为当前系统时间
>
> 	alter table mission
> 	add constraint defalut_start_time default(getdate()) for start_time

* time_consuming: 任务耗时 **[默认]**
> Default约束，默认时间为00:00:00.000000
>
> 	alter table mission
> 	add constraint defalut_time_consuming default('00:00:00') for time_consuming

* complete_time: 完成时间 **[允许NULL]**
* note: 笔记 **[允许NULL]**
* mark: 标记任务是否完成 **[默认]**
> Default约束，默认为“1”
>
> 	alter table mission
> 	add constraint defalut_mark default(1) for mark

* mission_id(主键): 任务id **[默认]**

> 测试插入数据：
>
> 	insert into mission (uid,mission) values('1000','这是一个uid为1000的用户创建的一个项目')

**存储过程**
* add_mission: 新建任务时执行的存储过程
> 创建语句：
>
> 	Create proc add_mission @uid int, @mission nvarchar(50), @note nvarchar(max)
> 	As
> 	Begin
>		insert into mission (uid, mission, note)
>		values (@uid, @mission, @note)
> 	End
> 测试插入：
>
> 	exec add_mission '1000', '数据库插入测试', '美妙绝伦！'






