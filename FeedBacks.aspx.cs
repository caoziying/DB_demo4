using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_demo4
{
    public partial class FeedBacks : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["root"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            // 建立数据库连接
            string con = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
            SqlConnection connect = new SqlConnection(con);

            // 构建SQL查询语句，查询用户数据
            string cmd = "SELECT COUNT(CASE WHEN Ftype='功能请求' THEN 1 END) AS type0,COUNT(CASE WHEN Ftype='缺陷报告' THEN 1 END) AS type1, COUNT(CASE WHEN Ftype='用户界面反馈' THEN 1 END) AS type2, COUNT(CASE WHEN Ftype='性能问题' THEN 1 END) AS type3,COUNT(CASE WHEN Ftype='安全问题' THEN 1 END) AS type4,COUNT(CASE WHEN Ftype='文档和帮助反馈' THEN 1 END) AS type5, COUNT(CASE WHEN Ftype='用户体验反馈' THEN 1 END) AS type6, COUNT(CASE WHEN Ftype NOT IN('功能请求','缺陷报告','用户界面反馈','性能问题','安全问题','文档和帮助反馈','用户体验反馈') THEN 1 END) AS type7,COUNT(*) AS total FROM Feedback;";

            using (connect)
            {
                SqlCommand command = new SqlCommand(cmd, connect);
                connect.Open();

                SqlDataReader reader = command.ExecuteReader();


                reader.Read();
                this.num0.Text = "统计：共有用户反馈 " + reader["total"].ToString() + " 次其中：";
                this.num1.Text = "功能请求反馈 共 " + reader["type0"].ToString() + " 次";
                this.num2.Text = "缺陷报告反馈 共 " + reader["type1"].ToString() + " 次";
                this.num3.Text = "用户界面反馈 共 " + reader["type2"].ToString() + " 次";
                this.num4.Text = "性能问题反馈 共 " + reader["type3"].ToString() + " 次";
                this.num5.Text = "安全问题反馈 共 " + reader["type4"].ToString() + " 次";
                this.num6.Text = "文档和帮助反馈 共 " + reader["type5"].ToString() + " 次";
                this.num7.Text = "用户体验反馈 共 " + reader["type6"].ToString() + " 次";
                this.num8.Text = "其他类型反馈 共 " + reader["type7"].ToString() + " 次";
                reader.Close();
            }

            // 关闭数据库连接
            connect.Close();
        }
    }
}