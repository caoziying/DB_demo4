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
    public partial class SpotManagement : System.Web.UI.Page
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
            string cmd = "SELECT COUNT(*) sum FROM ScenicSpot";

            using (connect)
            {
                SqlCommand command = new SqlCommand(cmd, connect);
                connect.Open();

                SqlDataReader reader = command.ExecuteReader();


                reader.Read();
                this.nums.Text = "统计：共有注册景点 " + reader["sum"].ToString() + " 处";

                reader.Close();
            }

            // 关闭数据库连接
            connect.Close();

            // 构建 SQL 查询语句
            string query = "DECLARE @currentTime TIME = CONVERT(TIME, GETDATE());SELECT @currentTime nowtime,SS_id, SSname FROM view_spot_mes WHERE SSopen_start_time <= @currentTime AND SSopen_end_time >= @currentTime;";
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
                    spots += sdr["SSname"] + "、";
                    numss++;
                }

                this.now.Text = "当前时间： " + nowtime + "，当前开放的景点有：" + spots.Substring(0, spots.Length - 1) + "，共 " + numss + " 处";

                sdr.Close();
            }

            // 关闭数据库连接
            connects.Close();

            // 构建 SQL 查询语句
            string query1 = "SELECT SUM(SScap) total,SUM(SScap_res) total_res,SUM(SScap)-SUM(SScap_res) total_now FROM ScenicSpot;";   // 获取当前时间
            SqlConnection connect1 = new SqlConnection(con);
            using (connect1)
            {
                SqlCommand cmds = new SqlCommand(query1, connect1);
                connect1.Open();

                SqlDataReader sdr = cmds.ExecuteReader();

                int numss = 0;
                sdr.Read();


                this.nums2.Text = "当前注册的景点总最大容量：" + sdr["total"] + "， 总剩余容量：" + sdr["total_res"] + "，总正在游玩的人数：" + sdr["total_now"];

                sdr.Close();
            }

            // 关闭数据库连接
            connect1.Close();
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