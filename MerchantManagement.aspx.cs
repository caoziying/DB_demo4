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
    public partial class MerchantManagement : System.Web.UI.Page
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
            string cmd = "SELECT COUNT(CASE WHEN Mctype IN ('00') THEN 1 END) AS type0,COUNT(CASE WHEN Mctype IN ('01') THEN 1 END) AS type1,COUNT(*) AS total FROM Merchant;";

            using (connect)
            {
                SqlCommand command = new SqlCommand(cmd, connect);
                connect.Open();

                SqlDataReader reader = command.ExecuteReader();


                reader.Read();
                this.nums.Text = "统计：共有注册商户 " + reader["total"].ToString() + " 处，" + "其中 住宿(00) 类型商户共有 " + reader["type0"].ToString() + " 处，"+
                    "餐饮(01) 类型商户共有 " + reader["type1"].ToString() + " 处";

                reader.Close();
            }

            // 关闭数据库连接
            connect.Close();

            // 构建 SQL 查询语句
            string query = "DECLARE @currentTime TIME = CONVERT(TIME, GETDATE());SELECT @currentTime nowtime,Mc_id, Mcname FROM view_merchant WHERE Mopen_start_time <= @currentTime AND Mopen_end_time >= @currentTime;";
            // 获取当前时间
            SqlConnection connects = new SqlConnection(con);
            using (connects)
            {
                SqlCommand cmds = new SqlCommand(query, connects);
                connects.Open();

                SqlDataReader sdr = cmds.ExecuteReader();

                string nowtime = "";
                string spots = "";
                int numss = 0;
                while (sdr.Read())
                {
                    nowtime = sdr["nowtime"].ToString();
                    spots += sdr["Mcname"] + "、";
                    numss++;
                }

                this.now.Text = "当前时间： " + nowtime + "，当前开放的商户有：" + spots.Substring(0, spots.Length - 1) + "，共 " + numss + " 处";

                sdr.Close();
            }

            // 关闭数据库连接
            connects.Close();
        }

        protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            Response.Redirect("SpotManagement.aspx");
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            Response.Redirect("SpotManagement.aspx");
        }

    }
}