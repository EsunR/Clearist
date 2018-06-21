using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.IO;

public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //检测数据库状态
        string strCon = WebConfigurationManager.ConnectionStrings["account"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        try
        {
            con.Open();
            db_status.Text = "(已连接)";
            db_status.ForeColor = System.Drawing.ColorTranslator.FromHtml("Green");
        }
        catch(SqlException ex)
        {
            db_status.Text = "(未连接)";
            db_status.ForeColor = System.Drawing.ColorTranslator.FromHtml("Red");
        }
        finally
        {
            con.Close();
        }
    }
    /// <summary>
    /// 登录按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Button1_Click(object sender, EventArgs e)
    {
        string strCon = WebConfigurationManager.ConnectionStrings["account"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        con.Open();
        string sqlString = "select * from account where id = '" + TextBox1.Text + "'";
        SqlCommand com = new SqlCommand(sqlString, con);
        
        SqlDataReader dr = com.ExecuteReader();
        if (dr.Read())   //验证用户名是否存在
        {
            if (TextBox2.Text == dr[1].ToString())   //验证密码是否正确
            {
                //向cookie中写入用户id和uid，设置保存期限为7天
                Response.Cookies["id"].Value = dr[0].ToString();
                Response.Cookies["id"].Expires = DateTime.Now.AddDays(7);
                Response.Cookies["uid"].Value = dr[2].ToString();
                Response.Cookies["uid"].Expires = DateTime.Now.AddDays(7);
                //初始化删除任务（当cookie中mission_delete的值为0时，表示数据刷新前没有进行删除操作）
                Response.Cookies["mission_delete"].Value = "0";
                Response.Cookies["mission_delete"].Expires = DateTime.Now.AddDays(7);
                //初始化选择任务
                Response.Cookies["mission_selected"].Value = "";
                Response.Cookies["mission_selected"].Expires = DateTime.Now.AddDays(7);
                //初始化详细任务
                Response.Cookies["detailed"].Value = "0";
                Response.Cookies["detailed"].Expires = DateTime.Now.AddDays(7);
                //初始化新建子任务列表
                Response.Cookies["new_subtasks"].Value = "";
                Response.Cookies["new_subtasks"].Expires = DateTime.Now.AddDays(7);
                //初始化任务重命名
                Response.Cookies["mission_change"].Value = "";
                Response.Cookies["mission_change"].Expires = DateTime.Now.AddDays(7);
                //初始化备注重命名
                Response.Cookies["note_change"].Value = "";
                Response.Cookies["note_change"].Expires = DateTime.Now.AddDays(7);
                //初始化删除子任务列表
                Response.Cookies["subtasks_delete"].Value = "";
                Response.Cookies["subtasks_delete"].Expires = DateTime.Now.AddDays(7);
                //初始化还原任务列表
                Response.Cookies["mission_backup"].Value = "";
                Response.Cookies["mission_backup"].Expires = DateTime.Now.AddDays(7);
                //初始彻底删除原任务列表
                Response.Cookies["mission_delete_forever"].Value = "";
                Response.Cookies["mission_delete_forever"].Expires = DateTime.Now.AddDays(7);
                //页面重定向
                Response.Redirect("home.aspx");
            }
            else
            {
                Response.Write("<script>alert('密码错误请重试')</script>");
            }
        }
        else
        {
            Response.Write("<script>alert('ops！没有找到该用户！')</script>");
        }
        con.Close();
    }
    /// <summary>
    /// 注册按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Button3_Click(object sender, EventArgs e)
    {
        if(TextBox3.Text != "") //检测用户名是否为空
        {
            if (TextBox4.Text == TextBox5.Text)  //检测两次密码是否输入一致
            {
                if (TextBox4.Text != "")    //检测密码是否为空
                {
                    string id = TextBox3.Text;
                    string psw = TextBox4.Text;
                    string strCon = WebConfigurationManager.ConnectionStrings["account"].ConnectionString;
                    SqlConnection con = new SqlConnection(strCon);
                    //向数据库插入新用户的信息
                    con.Open();
                    string sqlString = "insert into account values ('" + id + "','" + psw + "')";
                    SqlCommand com = new SqlCommand(sqlString, con);
                    try
                    {
                        com.ExecuteNonQuery();
                        Response.Write("<script>alert('注册成功！')</script>");
                    }
                    catch(SqlException ex)
                    {
                        Response.Write("<script>alert('改用户名已被占用！')</script>");
                    }
                    finally
                    {
                        con.Close();
                    }
                }
                else
                {
                    Response.Write("<script>alert('密码不能为空！')</script>");
                }
            }
            else
            {
                Response.Write("<script>alert('两次密码输入不一致！')</script>");
            }
        }
        else
        {
            Response.Write("<script>alert('用户名不能为空！')</script>");
        }
        
    }

    protected void FormatDB_Click(object sender, EventArgs e)
    {
     //使用master数据库
        string strCon = WebConfigurationManager.ConnectionStrings["master"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        con.Open();
        //读取脚本
        /*
        备用方法：直接移动DataBase文件中存放的mdf和ldf文件到数据库文件中
        SqlCommand com = new SqlCommand();
        com.Connection = con;
        string path1 = System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "DataBase\\Clearist_Realease_Version.mdf";
        string path2 = System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "DataBase\\Clearist_Realease_Version.ldf";
        com.CommandText = "exec sp_attach_db Clearist, '" + path1 +"'" + ",'"+ path2 +"'";
        com.ExecuteNonQuery();
        con.Close();
        */
        SqlCommand com = new SqlCommand();
        com.Connection = con;
        //通过读取数据库sql脚本文件来初始化数据库，由于CommandText无法运行“GO”语句，所以在读到“GO”时就将已读的语句先执行
        string path = System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "\\DataBase\\ClearistDB.sql";
        StreamReader sr = new StreamReader(path, System.Text.Encoding.Default);
        string line = "";
        string sqlstr = "";
        while ((line = sr.ReadLine()) != null)
        {
            if(line == "GO")
            {
                try
                {
                    com.CommandText = sqlstr;
                    com.ExecuteNonQuery();
                }
                catch(Exception ex)
                {
                    //如果已经建立数据库就对数据库数据进行初始化操作
                    string path_2 = System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase + "\\DataBase\\RebuildDB.sql";
                    StreamReader sr_2 = new StreamReader(path_2, System.Text.Encoding.Default);
                    string line_2 = "";
                    string sqlstr_2 = "";
                    while ((line_2 = sr_2.ReadLine()) != null)
                    {
                        if(line_2 == "GO")
                        {
                            com.CommandText = sqlstr_2;
                            com.ExecuteNonQuery();
                            sqlstr_2 = "";
                        }
                        else
                        {
                            sqlstr_2 += line_2 + " ";
                        }
                    }
                    break;
                }
                finally
                {
                    sqlstr = "";
                }
            }
            else
            {
                sqlstr += line + " ";
            }
        }

    }
}