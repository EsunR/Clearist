﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;


public partial class home : System.Web.UI.Page
{
    private string id;
    private string uid;
    private string strCon;
    private SqlConnection accountCon;
    private SqlCommand accountCom;

    /// <summary>
    /// 连接account表
    /// </summary>
    private void OpenAccountDB()
    {
        strCon = WebConfigurationManager.ConnectionStrings["account"].ConnectionString;
        accountCon = new SqlConnection(strCon);
        accountCom = new SqlCommand();
        accountCom.Connection = accountCon;
        accountCon.Open();
    }
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

        


        //假如重载页面有删除操作，就在页面加载时删除该项
        int mission_delete = int.Parse(Request.Cookies["mission_delete"].Value);
        if(mission_delete != 0)
        {
            //改变数据库中的任务标记
            OpenAccountDB();
            accountCom.CommandText = "update mission set mark = 2 where mission_id = " + mission_delete;
            accountCom.ExecuteReader();
            accountCon.Close();

            Response.Cookies["mission_delete"].Value = "0";    //重置删除操作
            Response.Cookies["mission_delete"].Expires = DateTime.Now.AddDays(7);
        }

        //假如重载页前有选择操作，就在页面新页面加载时对任务状态进行更改
        string mission_selected_string = Request.Cookies["mission_selected"].Value;
        string[] mission_selected = mission_selected_string.Split(new Char[] { ',' });  //mission_selected为一个数组，记录着已标记为完成的任务的mission_id队列
        if (mission_selected_string != "")
        {
            //改变数据库中的任务标记
            for (int i = 0; i < mission_selected.Length; i++)
            {
                OpenAccountDB();
                accountCom.CommandText = "update mission set mark = 0 where mission_id = " + int.Parse(mission_selected[i]);
                accountCom.ExecuteReader();
                accountCon.Close();
            }

            Response.Cookies["mission_selected"].Value = "";    //重置选择操作
            Response.Cookies["mission_selected"].Expires = DateTime.Now.AddDays(7);
            
        }

        //获取当前任务数
        OpenAccountDB();
        accountCom.CommandText = "select COUNT(*) from mission where uid = " + uid + "and mark = 1";
        SqlDataReader missionCountReader = accountCom.ExecuteReader();
        while (missionCountReader.Read())
        {
            count_mission_num.Text = missionCountReader[0].ToString();
            Response.Cookies["mission_count"].Value = missionCountReader[0].ToString();
            Response.Cookies["mission_count"].Expires = DateTime.Now.AddDays(7);
        }
        missionCountReader.Close();
        accountCon.Close();

    }



    /// <summary>
    /// 修改密码“确定”按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void psw_suer_Click(object sender, EventArgs e)
    {
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

    /// <summary>
    /// 获取数据库中的mission字段，并将它们放在一个missionString字符串中，之间以“,”隔开
    /// </summary>
    /// <returns></returns>
    public string GetMissionList()
    {
        string missionString = "";
        OpenAccountDB();
        accountCom.CommandText = "select mission from mission where uid = " + uid + "and mark = 1";
        SqlDataReader missionListReader = accountCom.ExecuteReader();
        while (missionListReader.Read())
        {
            missionString += missionListReader[0].ToString() + ",";
        }
        missionListReader.Close();
        accountCon.Close();
        missionString = missionString.TrimEnd(',');//修剪掉最后一个“,”
        return missionString;
    }

    public string GetMissionIdQueue()
    {
        string mission_id_queue = "";
        //获取当前任务数
        OpenAccountDB();
        accountCom.CommandText = "select mission_id from mission where uid = " + uid + "and mark = 1";
        SqlDataReader missionListReader = accountCom.ExecuteReader();
        while (missionListReader.Read())
        {
            mission_id_queue += missionListReader[0].ToString() + ",";
        }
        missionListReader.Close();
        accountCon.Close();
        mission_id_queue = mission_id_queue.TrimEnd(',');//修剪掉最后一个“,”
        return mission_id_queue;
    }


    protected void add_mission_true_Click(object sender, EventArgs e)
    {
        string mission_name = add_mission_name.Value;
        string mission_note = add_mission_note.Value;
        //添加任务到数据库
        OpenAccountDB();
        accountCom.CommandText = "exec add_mission '" + uid + "', '" + mission_name + "', '" + mission_note + "'";
        accountCom.ExecuteNonQuery();
        accountCon.Close();
        Response.Redirect("home.aspx");
    }

    /// <summary>
    /// 神奇的测试按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void Button1_Click(object sender, EventArgs e)
    {
        string mission_selected_string = Request.Cookies["mission_selected"].Value;
        string[] mission_selected = mission_selected_string.Split(new Char[] { ',' });
    }
}