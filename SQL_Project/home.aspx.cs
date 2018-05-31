using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class home : System.Web.UI.Page
{
    private string id;
    private string uid;
    /// <summary>
    /// 初始化页面
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Page_Load(object sender, EventArgs e)
    {
        //向cookie读取当前用户的id和唯一标识uid
        id = Request.Cookies["id"].Value;
        uid = Request.Cookies["uid"].Value;
        Label1.Text = id;
        Label2.Text = uid;
    }

    /// <summary>
    /// 修改密码“确定”按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void psw_suer_Click(object sender, EventArgs e)
    {
        string strCon = WebConfigurationManager.ConnectionStrings["account"].ConnectionString;
        SqlConnection con = new SqlConnection(strCon);
        SqlCommand com = new SqlCommand();
        com.Connection = con;
        con.Open();
        //审核原密码是否正确
        com.CommandText = " select psw from account where uid = '" + uid + "' ";
        SqlDataReader dr = com.ExecuteReader();
        if (dr.Read())
        {
            if(old_psw.Text == dr[0].ToString())
            {
                //向account表覆盖原来的psw（密码）字段
                dr.Close();
                com.CommandText = "update account set psw = '" + new_psw.Text + "' where uid = '" + uid + "'";
                com.ExecuteNonQuery();
                psw_wrong.ForeColor = System.Drawing.Color.Green;
                psw_wrong.Text = "密码更改成功！";
            }
            else
            {
                psw_wrong.ForeColor = System.Drawing.Color.Red;
                psw_wrong.Text = "原密码错误！";
                dr.Close();
            }
        }
        con.Close();
    }
}