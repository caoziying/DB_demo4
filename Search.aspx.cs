using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_demo4
{
    public partial class Search : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
                // 保存搜索关键字和位置
                //Session["search_text"] = txtKeyword.Value;
                //Session["ddlLocation"] = ddlLocation.SelectedValue;
            }
            if (!IsPostBack)
            {
                // 仅在首次加载页面时执行以下代码
                if (Session["search_text"] != null && Session["ddlLocation"] == null)
                {
                    this.txtKeyword.Value = Session["search_text"].ToString();
                    // 调用Search
                    btnSearch_Click(sender, e);
                }      
                else if (Session["ddlLocation"] != null)
                {
                    this.txtKeyword.Value = Session["search_text"].ToString();
                    this.ddlLocation.SelectedValue = Session["ddlLocation"].ToString();
                    // 调用Filter
                    btnFilter_Click(sender, e);
                }
                    

                
            }
            
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = this.txtKeyword.Value;
            // 存入session
            Session["search_text"] = keyword;
            if (keyword.Length == 0)
            {
                DataTable dt = new DataTable();
                gvResults.DataSource = dt;
                gvResults.DataBind();
                return;
            }
                
            // 建立数据库连接
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;Initial Catalog=D:\\MYDB\\MYDB.MDF;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";//从web.config文件中读取连接字符串
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand();//创建命令对象
            cmd.Connection = connection;//设置命令对象的数据库连接属性
            try
            {
                // 查询语句获取
                cmd.CommandText = "SELECT SS_id, SSname, SScity, SSlocate_longitude, SSlocate_latitude, SSprice, SSrate, CASE WHEN SSphone IS NULL THEN '暂无联系方式' " +
                    "ELSE SSphone END AS SSphone, SScap, SScap_res, CASE WHEN SSopen_start_time IS NULL THEN '00:00:00' " +
                    "ELSE CONVERT(VARCHAR(8), SSopen_start_time, 108) END AS SSopen_start_time, CASE WHEN SSopen_end_time IS NULL THEN '24:00:00' " +
                    "ELSE CONVERT(VARCHAR(8), SSopen_end_time, 108) END AS SSopen_end_time FROM ScenicSpot" +
                    " WHERE SSname LIKE '%' + @keyword + '%' OR SScity LIKE '%' + @keyword + '%';";

                cmd.Parameters.AddWithValue("@keyword", keyword);

                // 打开数据库连接
                connection.Open();
                SqlDataReader sdr = cmd.ExecuteReader();//执行SQL命令，并获取查询结果

                DataTable dt = new DataTable();
                dt.Load(sdr);
                gvResults.DataSource = dt;
                gvResults.DataBind();
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

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            string keyword = this.txtKeyword.Value;
            string ddlLocation = this.ddlLocation.SelectedValue;
            // 存入session
            Session["search_text"] = keyword;
            Session["ddlLocation"] = ddlLocation;
            // 建立数据库连接
            string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;Initial Catalog=D:\\MYDB\\MYDB.MDF;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";//从web.config文件中读取连接字符串
            SqlConnection connection = new SqlConnection(connectionString);
            SqlCommand cmd = new SqlCommand();//创建命令对象
            cmd.Connection = connection;//设置命令对象的数据库连接属性
            try
            {
                // 查询语句获取
                // 108 为 SQL SERVER中时间格式的样式代码
                cmd.CommandText = "SELECT SS_id, SSname, SScity, SSlocate_longitude, SSlocate_latitude, SSprice, SSrate, CASE WHEN SSphone IS NULL THEN '暂无联系方式' " +
                    "ELSE SSphone END AS SSphone, SScap, SScap_res, CASE WHEN SSopen_start_time IS NULL THEN '00:00:00' " +
                    "ELSE CONVERT(VARCHAR(8), SSopen_start_time, 108) END AS SSopen_start_time, CASE WHEN SSopen_end_time IS NULL THEN '24:00:00' " +
                    "ELSE CONVERT(VARCHAR(8), SSopen_end_time, 108) END AS SSopen_end_time FROM ScenicSpot" +
                    " WHERE (SSname LIKE '%' + @keyword + '%' OR SScity LIKE '%' + @keyword + '%') AND (SScity LIKE '%' + @city + '%');";
                cmd.Parameters.AddWithValue("@keyword", keyword);
                cmd.Parameters.AddWithValue("@city", ddlLocation);

                // 打开数据库连接
                connection.Open();
                SqlDataReader sdr = cmd.ExecuteReader();//执行SQL命令，并获取查询结果

                DataTable dt = new DataTable();
                dt.Load(sdr);
                gvResults.DataSource = dt;
                gvResults.DataBind();
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

        protected void btnAddToItinerary_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            // 获取按钮的CommandArgument，即景点编号
            string ssId = btn.CommandArgument;

            // 判断Session中是否存在相同内容
            if (Session["TempFormData"] == null)
            {
                // 如果Session为空，则创建新的列表并将数据存入其中
                List<string> tempFormList = new List<string>();
                tempFormList.Add(ssId);

                // 将列表存入Session
                Session["TempFormData"] = tempFormList;
            }
            else
            {
                // 如果Session已存在，则检查是否存在相同内容
                List<string> tempFormList = (List<string>)Session["TempFormData"];
                if (!tempFormList.Contains(ssId))
                {
                    // 不存在相同的景点编号，将新的景点编号添加到列表中
                    tempFormList.Add(ssId);

                    // 更新会话中的临时数据列表
                    Session["TempFormData"] = tempFormList;
                }         
            }
        }

        /*protected void vResults_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowDetail")
            {
                string ssId = e.CommandArgument.ToString();

                // 查询数据库，获取详细信息
                // 建立数据库连接
                string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;Initial Catalog=D:\\MYDB\\MYDB.MDF;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";//从web.config文件中读取连接字符串
                SqlConnection connection = new SqlConnection(connectionString);
                SqlCommand cmd = new SqlCommand();//创建命令对象
                cmd.Connection = connection;//设置命令对象的数据库连接属性
                try
                {
                    // 查询语句获取
                    cmd.CommandText = "SELECT * FROM ScenicSpot WHERE SS_id = @ssId;";
                    cmd.Parameters.AddWithValue("@ssId", ssId);

                    // 打开数据库连接
                    connection.Open();
                    SqlDataReader sdr = cmd.ExecuteReader();//执行SQL命令，并获取查询结果

                    DataTable dt = new DataTable();
                    dt.Load(sdr);
                    detailsView.DataSource = dt;
                    detailsView.DataBind();

                    // 显示悬浮窗
                    this.popupContainer.Visible = true;
                    //ScriptManager.RegisterStartupScript(this, GetType(), "ShowPopup", "$('.popupContainer').show();", true);
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
                // 绑定到 DetailsView 控件
            }
        }
        */
        protected void btnShowDetail_Click(object sender, EventArgs e)
        {

            // 显示悬浮窗
            this.popupContainer.Visible = true;
            
            Button btn = (Button)sender;
            //GridViewRow row = (GridViewRow)btn.NamingContainer;

            //// 获取行中的数据
            //string id = row.Cells[0].Text; // 第一列的数据

            // 获取按钮的CommandArgument，即景点编号
            string ssId = btn.CommandArgument;

            this.hidSSId.Value = ssId;
           
        }
        
        protected void btnClosePopup_Click(object sender, EventArgs e)
        {
            // 隐藏悬浮窗
            this.popupContainer.Visible = false;
            //ScriptManager.RegisterStartupScript(this, GetType(), "ClosePopup", "$('.popupContainer').hide();", true);
        }


        protected void showRoute_Click(object sender, EventArgs e)
        {
            Response.Redirect("PersonPage.aspx#myTrips");
        }


    }
}