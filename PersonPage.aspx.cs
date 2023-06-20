using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_demo4
{
    public partial class PersonPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            this.lblUsername.Text = Session["username"].ToString();
            if (Session["TempFormData"] != null)
            {
                List<string> tempFormDataList = (List<string>)Session["TempFormData"];
                string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
                SqlConnection connection = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = connection;
                try
                {
                    // 构建查询语句
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append("SELECT SS_id, SSname, SScity, SSlocate_longitude, SSlocate_latitude, SSprice, SSrate, CASE WHEN SSphone IS NULL THEN '暂无联系方式' ELSE SSphone END AS SSphone, SScap, SScap_res, CASE WHEN SSopen_start_time IS NULL THEN '00:00:00' ELSE CONVERT(VARCHAR(8), SSopen_start_time, 108) END AS SSopen_start_time, CASE WHEN SSopen_end_time IS NULL THEN '24:00:00' ELSE CONVERT(VARCHAR(8), SSopen_end_time, 108) END AS SSopen_end_time FROM ScenicSpot WHERE SS_id IN (");

                    // 添加参数化查询参数
                    List<SqlParameter> parameters = new List<SqlParameter>();

                    // 添加SS_id参数和查询条件
                    for (int i = 0; i < tempFormDataList.Count; i++)
                    {
                        string paramName = "@param" + i;
                        queryBuilder.Append(paramName);
                        parameters.Add(new SqlParameter(paramName, tempFormDataList[i]));

                        // 添加逗号分隔符
                        if (i < tempFormDataList.Count - 1)
                        {
                            queryBuilder.Append(",");
                        }
                    }

                    queryBuilder.Append(")");

                    // 设置查询语句和参数
                    cmd.CommandText = queryBuilder.ToString();
                    cmd.Parameters.AddRange(parameters.ToArray());

                    // 打开数据库连接
                    connection.Open();
                    SqlDataReader sdr = cmd.ExecuteReader();

                    DataTable dt = new DataTable();
                    dt.Load(sdr);
                    gvMyTrips.DataSource = dt;
                    gvMyTrips.DataBind();
                }
                catch (Exception ex)
                {
                    // 处理异常
                }
                finally
                {
                    // 关闭数据库连接
                    connection.Close();
                }

                //gvMyTrips.DataSource = tempFormDataList;
                //gvMyTrips.DataBind();
            }
        }

        protected void btnDeleteFromItinerary_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            // 获取按钮的CommandArgument，即景点编号
            string ssId = btn.CommandArgument;
            if (Session["TempFormData"] == null)
                return;
            List<string> tempFormDataList = (List<string>)Session["TempFormData"];
            if(tempFormDataList.Count == 1)
            {
                tempFormDataList.Clear();
                Session["TempFormData"] = null;
            }
            tempFormDataList.Remove(ssId);

            string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString; 
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = connection;
            try
            {
                // 构建查询语句
                StringBuilder queryBuilder = new StringBuilder();
                queryBuilder.Append("SELECT SS_id, SSname, SScity, SSlocate_longitude, SSlocate_latitude, SSprice, SSrate, CASE WHEN SSphone IS NULL THEN '暂无联系方式' ELSE SSphone END AS SSphone, SScap, SScap_res, CASE WHEN SSopen_start_time IS NULL THEN '00:00:00' ELSE CONVERT(VARCHAR(8), SSopen_start_time, 108) END AS SSopen_start_time, CASE WHEN SSopen_end_time IS NULL THEN '24:00:00' ELSE CONVERT(VARCHAR(8), SSopen_end_time, 108) END AS SSopen_end_time FROM ScenicSpot WHERE SS_id IN (");

                // 添加参数化查询参数
                List<SqlParameter> parameters = new List<SqlParameter>();

                // 添加SS_id参数和查询条件
                for (int i = 0; i < tempFormDataList.Count; i++)
                {
                    string paramName = "@param" + i;
                    queryBuilder.Append(paramName);
                    parameters.Add(new SqlParameter(paramName, tempFormDataList[i]));

                    // 添加逗号分隔符
                    if (i < tempFormDataList.Count - 1)
                    {
                        queryBuilder.Append(",");
                    }
                }

                queryBuilder.Append(")");

                // 设置查询语句和参数
                cmd.CommandText = queryBuilder.ToString();
                cmd.Parameters.AddRange(parameters.ToArray());

                // 打开数据库连接
                connection.Open();
                SqlDataReader sdr = cmd.ExecuteReader();

                DataTable dt = new DataTable();
                dt.Load(sdr);
                gvMyTrips.DataSource = dt;
                gvMyTrips.DataBind();
            }
            catch (Exception ex)
            {
                // 处理异常
            }
            finally
            {
                // 关闭数据库连接
                connection.Close();

                Response.Redirect("PersonPage.aspx#myTrips");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string oldPass = txtOldPassword.Text;
            if(oldPass.Equals(Session["password"]) == false)
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