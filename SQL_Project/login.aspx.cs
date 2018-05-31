using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;


public partial class login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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
                //向cookie中写入用户id和uid，设置保存期限为1天
                Response.Cookies["id"].Value = dr[0].ToString();
                Response.Cookies["id"].Expires = DateTime.Now.AddDays(1);
                Response.Cookies["uid"].Value = dr[2].ToString();
                Response.Cookies["uid"].Expires = DateTime.Now.AddDays(1);
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
                    com.ExecuteNonQuery();
                    Response.Write("<script>alert('注册成功！')</script>");
                    con.Close();
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
}