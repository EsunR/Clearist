# Clearist
参考项目：番茄土豆 & 滴答清单

基于ASP.NET、SQL Server
***
## 数据库构成

### account表

**用来记录用户的账户信息**

* id: 记录用户名，可以为中文和英文，不可重复
* psw: 记录用户的密码
* uid(主键): 作为用户的唯一标识，用 IDENTITY(1000,1) 设置为自1000开始的自动填充字段

### mission表

**用来记录用户所记录的任务**

* uid: 记录者的uid
* mission: 记录任务的名字
* start_time: 任务开始时间（默认为建立任务的时间）
	* 用Default约束
* time_consuming: 任务耗时 **[允许NULL]**
* complete_time: 完成时间 **[允许NULL]**
* note: 笔记 **[允许NULL]**
* mark: 标记任务是否完成
* mission_id(主键): 任务id








