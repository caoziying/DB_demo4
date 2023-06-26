using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_demo4
{
    public partial class UserManagement : System.Web.UI.Page
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
            string cmd = "SELECT COUNT(*) sum FROM Users";

            using (connect)
            {
                SqlCommand command = new SqlCommand(cmd, connect);
                connect.Open();

                SqlDataReader reader = command.ExecuteReader();


                reader.Read();
                this.nums.Text = "统计：共有注册用户 " + reader["sum"].ToString() + " 人次";

                reader.Close();
            }

            // 关闭数据库连接
            connect.Close();
        }

        protected void SearchUser_Click(object sender, EventArgs e)
        {
            // 检查是否传递了查询参数
            string username = this.name.Value;
            if (!string.IsNullOrEmpty(username))
            {
                // 执行查询操作，将查询结果绑定到 userTable 控件
                // TODO: 根据实际需求，构建查询语句并处理查询结果
                // 建立数据库连接
                string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
                SqlConnection connection = new SqlConnection(connectionString);

                // 构建查询语句，带有参数化查询来防止 SQL 注入攻击
                string query = "SELECT * FROM Users WHERE Uname LIKE '%' + @Username + '%';";

                using (connection)
                {
                    SqlCommand command = new SqlCommand(query, connection);

                    // 添加参数，指定待查询的用户名
                    command.Parameters.AddWithValue("@Username", username);
                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();

                    // 将查询结果绑定到 userTable 控件
                    userTable.DataSource = reader;
                    userTable.DataBind();

                    reader.Close();
                }

                // 关闭数据库连接
                connection.Close();
            }
            else
            {
                // 没有传递查询参数时，默认显示全部用户
                // 查询数据库并将结果绑定到 userTable 控件

                // 建立数据库连接
                string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
                SqlConnection connection = new SqlConnection(connectionString);

                // 构建SQL查询语句，查询用户数据
                string query = "SELECT * FROM Users";

                using (connection)
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    connection.Open();

                    SqlDataReader reader = command.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(reader);
                    // 将查询结果绑定到 userTable 控件
                    userTable.DataSource = dt;
                    userTable.DataBind();

                    reader.Close();
                }

                // 关闭数据库连接
                connection.Close();
            }
            
        }
    }
}