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
    public partial class NoticeManagement : System.Web.UI.Page
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

            string cmd = "SELECT COUNT(CASE WHEN M_id = @M_id THEN 1 END) AS my, COUNT(*) AS total FROM Notice;";
            SqlCommand command = new SqlCommand(cmd, connect);
            command.Parameters.AddWithValue("@M_id", int.Parse(Session["root_id"].ToString()));

            using (connect)
            {
                connect.Open();

                SqlDataReader reader = command.ExecuteReader();


                reader.Read();
                this.nums.Text = "统计：共发布公告 " + reader["total"].ToString() + " 次，其中 我 共发布公告 " + reader["my"].ToString() + " 次";

                reader.Close();
            }

            // 关闭数据库连接
            connect.Close();
        }
        protected void btnSubmitNotice_Click(object sender, EventArgs e)
        {
            int M_id = int.Parse(Session["root_id"].ToString());
            string content = this.txtNotice.Text;
            // 更新密码的代码...
            string strcon = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString; ;//从web.config文件中读取连接字符串
            SqlConnection con = new SqlConnection(strcon);//定义连接对象
            SqlCommand cmd = new SqlCommand();//创建命令对象
            cmd.Connection = con;//设置命令对象的数据库连接属性

            //this.label.Text = this.password.ToString();
            cmd.CommandText = "INSERT INTO Notice VALUES(@M_id,@content,@timestamp)";
            cmd.Parameters.AddWithValue("@M_id", M_id);
            cmd.Parameters.AddWithValue("@content", content);
            cmd.Parameters.AddWithValue("@timestamp", DateTime.Now);

            con.Open();//打开数据库连接
                       //Response.Write("连接数据库查询成功");
            try
            {
                cmd.ExecuteReader(); // Execute SQL command and get the query result
                                     // Insertion successful
                                     // Delay for two seconds
                lblMessage1.Text = "公告已发布。";
                Response.Redirect("NoticeManagement.aspx");
            }
            catch (SqlException ex)
            {
                lblMessage1.Text = "出现异常，公告发布失败。";
            }
            finally
            {
                con.Close(); // Close the database connection
            }
        }
    }
}