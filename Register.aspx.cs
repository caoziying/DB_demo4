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
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void RegisterForm(object sender, EventArgs e)
        {
            string strcon = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString; ;//从web.config文件中读取连接字符串
            SqlConnection con = new SqlConnection(strcon);//定义连接对象
            SqlCommand cmd = new SqlCommand();//创建命令对象
            cmd.Connection = con;//设置命令对象的数据库连接属性
            string username = this.username.Value;
            string password = this.password.Value;
            string password1 = this.password1.Value;
            if(password.Equals(password1) == false)
            {
                this.label.Text = "两次密码不匹配，请重新输入";
                this.password.Value = "";
                this.password1.Value = "";
                return;
            }
            //this.label.Text = this.password.ToString();
            cmd.CommandText = "INSERT INTO Users VALUES(@username, @password)";
            cmd.Parameters.AddWithValue("@username", username);
            cmd.Parameters.AddWithValue("@password", password);
            this.label.Text = username;
            con.Open();//打开数据库连接
            //Response.Write("连接数据库查询成功");
            try
            {
                cmd.ExecuteReader(); // Execute SQL command and get the query result
                                     // Insertion successful
                                     // Delay for two seconds
                // 进行页面跳转
                Response.Redirect("Login.aspx");
                //ClientScript.RegisterStartupScript(GetType(), "alert", "alert('注册成功！');setTimeout(function(){window.location.href='Login.aspx';}, 0);", true);
            }
            catch (SqlException ex)
            {
                // Handle the exception
                if (ex.Number == 2627) // Error number for unique constraint violation
                {
                    this.label.Text = "用户名已存在，请选择另一个用户名"; // Display an appropriate error message
                }
                else
                {
                    this.label.Text = "注册失败：" + ex.Message; // Display a generic error message with the exception details
                }
            }
            finally
            {
                con.Close(); // Close the database connection
            }
        }

        protected void Reset(object sender, EventArgs e)
        {
            this.username.Value = "";
            this.password.Value = "";
            this.password1.Value = "";

        }

        protected void ReturnLogin(object sender, EventArgs e)
        {
            // 进行页面跳转
            Response.Redirect("Login.aspx");
        }
    }
}