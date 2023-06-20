using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_demo4
{
    public partial class main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            // 建立数据库连接
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;Initial Catalog=D:\\MYDB\\MYDB.MDF;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";//从web.config文件中读取连接字符串
            SqlConnection connection = new SqlConnection(connectionString);

            try
            {
                // 打开数据库连接
                connection.Open();

                // 执行查询语句获取公示内容（获取时间上最新的一个）
                string query = "SELECT TOP 1 Mname,Ncontent FROM Notice,Manager WHERE Notice.M_id=Manager.M_id ORDER BY Ntime DESC;";
                SqlCommand command = new SqlCommand(query, connection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    // 读取查询结果并插入到公示栏中
                   // string 公示标题 = reader["公示标题"].ToString();
                    string Mname = reader["Mname"].ToString();
                    string Ncontent = reader["Ncontent"].ToString();
                    this.Mname.Text = "发布人：" + Mname;
                    this.Ncontent.Text = Ncontent;
                }

                reader.Close();
            }
            catch (Exception ex)
            {
                // 处理异常
                // 可以在此处添加错误处理逻辑，如记录日志或显示错误信息
            }
            finally
            {
                // 关闭数据库连接
                connection.Close();
            }
        }
    }
}