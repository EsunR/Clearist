using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;

public partial class trash : System.Web.UI.Page
{
    private string id;
    private string uid;
    private string strCon;
    private SqlConnection accountCon;
    private SqlCommand accountCom;

    /// <summary>
    /// 连接数据库
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
        //获取当前用户id和uid
        id = Request.Cookies["id"].Value;
        uid = Request.Cookies["uid"].Value;


    }

    /// <summary>
    /// 获取任务名字构成的字符串
    /// </summary>
    /// <returns></returns>
    public string GetCompletedMissionList()
    {
        string missionString = "";
        OpenAccountDB();
        accountCom.CommandText = "select mission from mission where uid = " + uid + "and mark = 0";
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

    /// <summary>
    /// 获取任务id构成的字符串
    /// </summary>
    /// <returns></returns>
    public string GetCompletedMissionId()
    {
        string missionString = "";
        OpenAccountDB();
        accountCom.CommandText = "select mission_id from mission where uid = " + uid + "and mark = 0";
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

    protected void confirm_button_Click(object sender, EventArgs e)
    {
        string delete_forever_string = Request.Cookies["mission_delete_forever"].Value;
        string backup_string = Request.Cookies["mission_backup"].Value;
        //执行彻底删除任务的语句
        if (delete_forever_string != "")
        {
            string[] delete_forever_arr = delete_forever_string.Split(',');
            OpenAccountDB();
            for (int i = 0; i < delete_forever_arr.Length; i++)
            {
                accountCom.CommandText = "Update Mission Set mark = 2 Where mission_id = " + delete_forever_arr[i];
                accountCom.ExecuteNonQuery();
            }
            accountCon.Close();
        }
        //执行还原任务的语句
        if (backup_string != "")
        {
            string[] backup_arr = backup_string.Split(',');
            OpenAccountDB();
            for (int i = 0; i < backup_arr.Length; i++)
            {
                accountCom.CommandText = "Update Mission Set mark = 1 Where mission_id = " + backup_arr[i];
                accountCom.ExecuteNonQuery();
            }
            accountCon.Close();
        }
        Response.Cookies["mission_delete_forever"].Value = "";
        Response.Cookies["mission_backup"].Value = "";
    }
}