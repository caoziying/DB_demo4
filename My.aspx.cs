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
    public partial class My : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            this.lblUsername.Text = Session["username"].ToString();
        }
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string oldPass = txtOldPassword.Text;
            if (oldPass.Equals(Session["password"]) == false)
            {
                lblMessage.Text = "旧密码错误";
                return;
            }
            // 处理修改密码的逻辑
            string newPassword = txtNewPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;
            string username = Session["username"].ToString();
            if (newPassword == confirmPassword)
            {
                // 更新密码的代码...
                string strcon = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString; ;//从web.config文件中读取连接字符串
                SqlConnection con = new SqlConnection(strcon);//定义连接对象
                SqlCommand cmd = new SqlCommand();//创建命令对象
                cmd.Connection = con;//设置命令对象的数据库连接属性

                //this.label.Text = this.password.ToString();
                cmd.CommandText = "UPDATE Users SET Upass=@password WHERE Uname=@username";
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", newPassword);

                con.Open();//打开数据库连接
                           //Response.Write("连接数据库查询成功");
                try
                {
                    cmd.ExecuteReader(); // Execute SQL command and get the query result
                                         // Insertion successful
                                         // Delay for two seconds
                    lblMessage.Text = "密码已成功修改。";
                    Session["password"] = newPassword;
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "出现异常，密码修改失败。";
                }
                finally
                {
                    con.Close(); // Close the database connection
                }
                // 显示成功消息
                //Server.Transfer("PersonPage.aspx#myProfile", false);


                //
            }
            else
            {
                // 显示错误消息
                //Server.Transfer("PersonPage.aspx#myProfile", false);
                lblMessage.Text = "两次密码不匹配。";
                //
            }
        }

        protected void btnSubmitFeedback_Click(object sender, EventArgs e)
        {

        }
    }
}