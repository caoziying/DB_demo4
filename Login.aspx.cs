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
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {
            string strcon = "Data Source=(LocalDB)\\MSSQLLocalDB;Initial Catalog=D:\\MYDB\\MYDB.MDF;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";//从web.config文件中读取连接字符串
            SqlConnection con = new SqlConnection(strcon);//定义连接对象
            SqlCommand cmd = new SqlCommand();//创建命令对象
            cmd.Connection = con;//设置命令对象的数据库连接属性
            string username = this.username.Value;
            string password = this.password.Value;
            string usertype = this.userType.Value;
            //this.label.Text = this.password.ToString();
            if(usertype.Equals("normal"))
            {
                cmd.CommandText = "SELECT * FROM Users WHERE Uname=@username AND Upass=@password";
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                this.label.Text = username;
                con.Open();//打开数据库连接
                //Response.Write("连接数据库查询成功");

                SqlDataReader sdr = cmd.ExecuteReader();//执行SQL命令，并获取查询结果
                if (sdr.HasRows)
                {
                    //this.label.Text = "Succeed";
                    Session["username"] = username;
                    Session["password"] = password;
                    Response.Redirect("main.aspx");
                    //ClientScript.RegisterStartupScript(GetType(), "alert", "alert('登录成功！');setTimeout(function(){window.location.href='main.aspx';}, 0);", true);
                }
                else
                    this.label.Text = "Login Failed";
            }
            else if(usertype.Equals("admin"))
            {
                cmd.CommandText = "SELECT * FROM Manager WHERE Mname=@username AND Mpass=@password";
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                this.label.Text = username;
                con.Open();//打开数据库连接
                //Response.Write("连接数据库查询成功");

                SqlDataReader sdr = cmd.ExecuteReader();//执行SQL命令，并获取查询结果
                if (sdr.HasRows)
                {
                    Session["root"] = username;
                    Session["pass"] = password;
                    this.label.Text = "Succeed";
                }
                else
                    this.label.Text = "Login Failed";
            }
            
        }

        protected void resetForm(object sender, EventArgs e)
        {
            this.username.Value = "";
            this.password.Value = "";
            this.userType.Value = "normal";

        }

        protected void Register(object sender, EventArgs e)
        {
            // 进行页面跳转
            Response.Redirect("Register.aspx");
        }
    }
}