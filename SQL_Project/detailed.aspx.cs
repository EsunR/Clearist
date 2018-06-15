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
using System.Text;  //转换编码用

public partial class detailed : System.Web.UI.Page
{
    private string strCon;
    private SqlConnection accountCon;
    private SqlCommand accountCom;
    int mission_id; //获取mission_id

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

    protected void Page_Load(object sender, EventArgs e)
    {
        mission_id = int.Parse(Request.Cookies["detailed"].Value);
        OpenAccountDB();
        //读取任务名字、备注、任务耗时、任务开始时间
        accountCom.CommandText = "select * from mission where mission_id = " + mission_id;
        SqlDataReader DataReader = accountCom.ExecuteReader();
        while (DataReader.Read())
        {
            md_name.Text = DataReader[1].ToString();
            md_note.Text = DataReader[5].ToString();
            time_cost_num.Text = DataReader[3].ToString();
            start_time_num.Text = DataReader[2].ToString();
        }
        DataReader.Close();
        accountCon.Close();
    }

    /// <summary>
    /// 获取当前子任务名字
    /// </summary>
    /// <returns></returns>
    public string GetSubtasks()
    {
        string subtasks_string = "";
        //获取当前任务数
        OpenAccountDB();
        accountCom.CommandText = "select subtasks from subtasks where mission_id = " + mission_id + "order by subtasks_id";
        SqlDataReader SubtasksListReader = accountCom.ExecuteReader();
        while (SubtasksListReader.Read())
        {
            subtasks_string += SubtasksListReader[0].ToString() + ",";
        }
        SubtasksListReader.Close();
        accountCon.Close();
        subtasks_string = subtasks_string.TrimEnd(',');//修剪掉最后一个“,”
        return subtasks_string;
    }

    /// <summary>
    /// 获取一个数组格式的字符串存放当前子任务id
    /// </summary>
    /// <returns></returns>
    public string GetSubtasksId()
    {
        string subtasks_id_string = "";
        //获取当前任务数
        OpenAccountDB();
        accountCom.CommandText = "select subtasks_id from subtasks where mission_id = " + mission_id + "order by subtasks_id";
        SqlDataReader SubtasksListReader = accountCom.ExecuteReader();
        while (SubtasksListReader.Read())
        {
            subtasks_id_string += SubtasksListReader[0].ToString() + ",";
        }
        SubtasksListReader.Close();
        accountCon.Close();
        subtasks_id_string = subtasks_id_string.TrimEnd(',');//修剪掉最后一个“,”
        return subtasks_id_string;
    }

    /// <summary>
    /// “应用更改”按钮
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void detailed_apply_Click(object sender, EventArgs e)
    {

        //将用户插入的数据从cookie缓存中提取并逐条写入数据库
        string new_subtasks_string = HttpUtility.UrlDecode(Request.Cookies["new_subtasks"].Value, Encoding.GetEncoding("UTF-8"));//利用UrlDecode解码UrlEncode
        string[] new_subtasks = new_subtasks_string.Split(new char[] { ',' });
        if(new_subtasks_string != "")
        {
            //将新建的子任务逐条插入到数据库中
            for (int i = 0; i < new_subtasks.Length; i++)
            {
                OpenAccountDB();
                //执行存储过程add_subtasks存放新任务
                accountCom.CommandText = "exec add_subtasks '" + mission_id + "', '" + new_subtasks[i] + "'";
                accountCom.ExecuteReader();
                accountCon.Close();
            }
        }

        //将用户更改的信息写入数据库
        OpenAccountDB();
        string md_name_string = HttpUtility.UrlDecode(Request.Cookies["mission_change"].Value, Encoding.GetEncoding("UTF-8"));
        string md_note_string = HttpUtility.UrlDecode(Request.Cookies["note_change"].Value, Encoding.GetEncoding("UTF-8"));
        accountCom.CommandText = "exec alter_mission '" + mission_id + "','" + md_name_string + "','" + md_note_string + "'";
        accountCom.ExecuteReader();
        accountCon.Close();

        //将用户删除的子任务从数据库中移除
        string subtasks_delete_string = Request.Cookies["subtasks_delete"].Value;
        string[] subtasks_delete = subtasks_delete_string.Split(new Char[] { ',' });
        if (subtasks_delete_string != "")
        {
            //改变数据库中的任务标记
            for (int i = 0; i < subtasks_delete.Length; i++)
            {
                OpenAccountDB();
                accountCom.CommandText = "delete from subtasks where subtasks_id = " + subtasks_delete[i];
                accountCom.ExecuteReader();
                accountCon.Close();
            }
        }

        //重置cookie，刷新当前页面
        Response.Cookies["new_subtasks"].Value = "";
        Response.Cookies["mission_change"].Value = "";
        Response.Cookies["note_change"].Value = "";
        Response.Cookies["subtasks_delete"].Value = "";
        Response.Redirect("/home.aspx");

    }
}