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

public partial class detailed : System.Web.UI.Page
{
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

    protected void Page_Load(object sender, EventArgs e)
    {
        int mission_id = int.Parse(Request.Cookies["detailed"].Value);
        OpenAccountDB();
        accountCom.CommandText = "select * from mission where mission_id = " + mission_id;
        SqlDataReader DataReader = accountCom.ExecuteReader();
        while (DataReader.Read())
        {
            md_name.Text = DataReader[1].ToString();
            md_note.Text = DataReader[5].ToString();
        }
        DataReader.Close();
        accountCon.Close();
    }
}