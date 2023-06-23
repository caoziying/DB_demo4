using Newtonsoft.Json;
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

                // 创建DataTable用于存储用户表和商户表内容
                DataTable tempTable = new DataTable();
                tempTable.Columns.Add("Id", typeof(int));
                tempTable.Columns.Add("Name", typeof(string));
                tempTable.Columns.Add("Type", typeof(string));
                tempTable.Columns.Add("OpenStartTime", typeof(string));
                tempTable.Columns.Add("OpenEndTime", typeof(string));
                tempTable.Columns.Add("Phone", typeof(string));
                tempTable.Columns.Add("Cap_res", typeof(string));
                tempTable.Columns.Add("longitude", typeof(string));
                tempTable.Columns.Add("latitude", typeof(string));
                try
                {
                    // 构建查询语句和参数
                    StringBuilder queryBuilder = new StringBuilder();
                    queryBuilder.Append("SELECT DISTINCT SS_id, SSname, SScity, SSlocate_longitude, SSlocate_latitude, SSprice, SSrate, CASE WHEN SSphone IS NULL THEN '暂无联系方式' ELSE SSphone END AS SSphone, SScap, SScap_res, CASE WHEN SSopen_start_time IS NULL THEN '00:00:00' ELSE CONVERT(VARCHAR(8), SSopen_start_time, 108) END AS SSopen_start_time, CASE WHEN SSopen_end_time IS NULL THEN '24:00:00' ELSE CONVERT(VARCHAR(8), SSopen_end_time, 108) END AS SSopen_end_time FROM ScenicSpot WHERE SS_id IN (");

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
                    string query = queryBuilder.ToString();
                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddRange(parameters.ToArray());

                    // 打开数据库连接
                    connection.Open();

                    // 执行查询景点表
                    SqlDataReader sdr = cmd.ExecuteReader();

                    while (sdr.Read())
                    {
                        string id = sdr["SS_id"].ToString();
                        string name = sdr["SSname"].ToString();
                        string type = "景点";
                        string phone = sdr["SSphone"].ToString();
                        string longitude = sdr["SSlocate_longitude"].ToString();
                        string latitude = sdr["SSlocate_latitude"].ToString();
                        string startTime = sdr["SSopen_start_time"].ToString();
                        string endTime = sdr["SSopen_end_time"].ToString();
                        string cap_res = sdr["SScap_res"].ToString();
                        
                        
                        string newId = id.PadLeft(4, '0');
                        bool isDuplicate = false;

                        // Iterate through the rows and check for duplicate id
                        foreach (DataRow row in tempTable.Rows)
                        {
                            string existingId = row["id"].ToString();

                            if (existingId == newId.PadLeft(4, '0'))
                            {
                                isDuplicate = true;
                                break;
                            }
                        }

                        if (!isDuplicate)
                        {
                            tempTable.Rows.Add(id.PadLeft(4, '0'), name, type, startTime, endTime, phone, cap_res, longitude, latitude);
                        }
                    }

                    sdr.Close();

                    /* 商户查询 */
                    // 构建查询语句和参数
                    StringBuilder queryBuilder1 = new StringBuilder();
                    queryBuilder1.Append("SELECT DISTINCT Mc_id, Mcname, Mctype, Mclocate_longitude, Mclocate_latitude, CASE WHEN Mcphone IS NULL THEN '暂无联系方式' ELSE Mcphone END AS Mcphone, CASE WHEN Mopen_start_time IS NULL THEN '00:00:00' ELSE CONVERT(VARCHAR(8), Mopen_start_time, 108) END AS Mopen_start_time, CASE WHEN Mopen_end_time IS NULL THEN '24:00:00' ELSE CONVERT(VARCHAR(8), Mopen_end_time, 108) END AS Mopen_end_time FROM Merchant WHERE Mc_id IN (");

                    // 添加参数化查询参数
                    List<SqlParameter> parameters1 = new List<SqlParameter>();

                    // 添加Mc_id参数和查询条件
                    for (int i = 0; i < tempFormDataList.Count; i++)
                    {
                        string paramName = "@param1_" + i;
                        queryBuilder1.Append(paramName);
                        parameters1.Add(new SqlParameter(paramName, tempFormDataList[i]));

                        // 添加逗号分隔符
                        if (i < tempFormDataList.Count - 1)
                        {
                            queryBuilder1.Append(",");
                        }
                    }

                    queryBuilder1.Append(")");

                    // 设置查询语句和参数
                    string query1 = queryBuilder1.ToString();
                    SqlCommand cmd1 = new SqlCommand(query1, connection);
                    cmd1.Parameters.AddRange(parameters1.ToArray());

                    // 执行查询商户表
                    SqlDataReader reader = cmd1.ExecuteReader();

                    while (reader.Read())
                    {
                        string id = reader["Mc_id"].ToString();
                        string name = reader["Mcname"].ToString();
                        string type = "";
                        if (reader["Mctype"].ToString().Equals("00"))
                            type = "住宿";
                        else if (reader["Mctype"].ToString().Equals("01"))
                            type = "餐饮";
                        string phone = reader["Mcphone"].ToString().Length == 0 ? "暂无联系方式" : reader["Mcphone"].ToString();
                        string longitude = reader["Mclocate_longitude"].ToString();
                        string latitude = reader["Mclocate_latitude"].ToString();
                        string startTime = reader["Mopen_start_time"].ToString().Length == 0 ? "00:00:00" : reader["Mopen_start_time"].ToString();
                        string endTime = reader["Mopen_end_time"].ToString().Length == 0 ? "24:00:00" : reader["Mopen_end_time"].ToString();
                        string cap_res = "∞";

                        string newId = id.PadLeft(5, '0');
                        bool isDuplicate = false;

                        // Iterate through the rows and check for duplicate id
                        foreach (DataRow row in tempTable.Rows)
                        {
                            string existingId = row["id"].ToString();

                            if (existingId == newId.PadLeft(5, '0'))
                            {
                                isDuplicate = true;
                                break;
                            }
                        }

                        if (!isDuplicate)
                        {
                            tempTable.Rows.Add(id.PadLeft(5, '0'), name, type, startTime, endTime, phone, cap_res, longitude, latitude);
                        }
                    }


                    // 排序
                    // 假设tempTable是你原始的DataTable对象
                    // 假设tempFormDataList是存储ID序列的List<string>对象

                    //创建一个新的DataTable来存储重新排序后的元组
                   DataTable sortedTable = tempTable.Clone();

                    // 使用LINQ按照tempFormDataList中的ID顺序重新排序元组
                    var sortedRows = tempFormDataList.Select(id => tempTable.Select($"id = '{id}'")).SelectMany(row => row);

                    // 将排序后的元组添加到新的DataTable中
                    int ind = 0;
                    foreach (var row in sortedRows)
                    {
                        //if(ind < tempFormDataList.Count())
                        sortedTable.ImportRow(row);
                        ind++;
                    }

                    //List<DataRow> sortedRows = new List<DataRow>();
                    //// 创建新的 DataTable
                    //DataTable newDataTable = tempTable.Clone();

                    //// 迭代 tempFormDataList 中的 id 序列
                    //foreach (string id in tempFormDataList)
                    //{
                    //    // 在 tempTable 中查找匹配的元组
                    //    DataRow matchingRow = null;
                    //    foreach (DataRow row in tempTable.Rows)
                    //    {
                    //        if (row["id"].ToString() == id & row["id"].ToString().Length == id.Length)
                    //        {
                    //            matchingRow = row;
                    //            break;
                    //        }
                    //    }

                    //    // 将匹配的元组添加到新的 DataTable 中
                    //    if (matchingRow != null)
                    //    {
                    //        sortedRows.Add(matchingRow);
                    //        newDataTable.ImportRow(matchingRow);
                    //    }
                    //}

                    gvMyTrips.DataSource = sortedTable;
                    gvMyTrips.DataBind();

                    /*               取出经纬度              */
                    List<string> LongitudeList = new List<string>();
                    List<string> LatitudeList = new List<string>();
                    //LongitudeList.Add("111.11111");
                    //LatitudeList.Add("111.22222");
                    foreach (var row in sortedRows)
                    {
                        string longitude = row["longitude"].ToString();
                        string latitude = row["latitude"].ToString();
                        LongitudeList.Add(longitude);
                        LatitudeList.Add(latitude);
                    }

                    // 将coordinatesList存储在Session中
                    Session["LongitudeList"] = JsonConvert.SerializeObject(LongitudeList);
                    Session["LatitudeList"] = JsonConvert.SerializeObject(LatitudeList);

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
            string commandArgument = btn.CommandArgument;
            string[] values = commandArgument.Split(',');

            string id = values[0];  // 第一个值为 Id
            string type = values[1];  // 第二个值为 Type
            if(type.Equals("景点"))
                id = id.PadLeft(4, '0');
            else
                id = id.PadLeft(5, '0');
            if (Session["TempFormData"] == null)
                return;
            List<string> tempFormDataList = (List<string>)Session["TempFormData"];
            if(tempFormDataList.Count == 1)
            {
                tempFormDataList.Clear();
                Session["TempFormData"] = null;
            }
            tempFormDataList.Remove(id);
            Session["TempFormData"] = tempFormDataList;
            Response.Redirect("PersonPage.aspx#myTrips");
            //string connectionString = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString; 
            //SqlConnection connection = new SqlConnection(connectionString);
            //SqlCommand cmd = new SqlCommand();
            //cmd.Connection = connection;
            //try
            //{
            //    // 构建查询语句
            //    StringBuilder queryBuilder = new StringBuilder();
            //    queryBuilder.Append("SELECT SS_id, SSname, SScity, SSlocate_longitude, SSlocate_latitude, SSprice, SSrate, CASE WHEN SSphone IS NULL THEN '暂无联系方式' ELSE SSphone END AS SSphone, SScap, SScap_res, CASE WHEN SSopen_start_time IS NULL THEN '00:00:00' ELSE CONVERT(VARCHAR(8), SSopen_start_time, 108) END AS SSopen_start_time, CASE WHEN SSopen_end_time IS NULL THEN '24:00:00' ELSE CONVERT(VARCHAR(8), SSopen_end_time, 108) END AS SSopen_end_time FROM ScenicSpot WHERE SS_id IN (");

            //    // 添加参数化查询参数
            //    List<SqlParameter> parameters = new List<SqlParameter>();

            //    // 添加SS_id参数和查询条件
            //    for (int i = 0; i < tempFormDataList.Count; i++)
            //    {
            //        string paramName = "@param" + i;
            //        queryBuilder.Append(paramName);
            //        parameters.Add(new SqlParameter(paramName, tempFormDataList[i]));

            //        // 添加逗号分隔符
            //        if (i < tempFormDataList.Count - 1)
            //        {
            //            queryBuilder.Append(",");
            //        }
            //    }

            //    queryBuilder.Append(")");

            //    // 设置查询语句和参数
            //    cmd.CommandText = queryBuilder.ToString();
            //    cmd.Parameters.AddRange(parameters.ToArray());

            //    // 打开数据库连接
            //    connection.Open();
            //    SqlDataReader sdr = cmd.ExecuteReader();

            //    DataTable dt = new DataTable();
            //    dt.Load(sdr);
            //    gvMyTrips.DataSource = dt;
            //    gvMyTrips.DataBind();
        //}
            //catch (Exception ex)
            //{
            //    // 处理异常
            //}
            //finally
            //{
            //    // 关闭数据库连接
            //    connection.Close();

            //    Response.Redirect("PersonPage.aspx#myTrips");
            //}
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
            string content = this.txtFeedback.Text;
            string type = this.ddlFeedbackType.Value;
            string strcon = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString; ;//从web.config文件中读取连接字符串
            SqlConnection con = new SqlConnection(strcon);//定义连接对象
            SqlCommand cmd = new SqlCommand();//创建命令对象
            cmd.Connection = con;//设置命令对象的数据库连接属性

            //this.label.Text = this.password.ToString();
            cmd.CommandText = "INSERT INTO Feedback VALUES(@U_id,@Ftime,@Ftype,@Fcontent)";
            cmd.Parameters.AddWithValue("@U_id", Session["uid"]);
            cmd.Parameters.AddWithValue("@Ftime", DateTime.Now.ToString());
            cmd.Parameters.AddWithValue("@Ftype", type);
            cmd.Parameters.AddWithValue("@Fcontent", content);

            con.Open();//打开数据库连接
                       //Response.Write("连接数据库查询成功");
            try
            {
                cmd.ExecuteReader(); // Execute SQL command and get the query result
                                     // Insertion successful
                                     // Delay for two seconds
                lblMessage1.Text = "已提交";
            }
            catch (SqlException ex)
            {
                lblMessage1.Text = "出现异常，提交失败。";
            }
            finally
            {
                con.Close(); // Close the database connection
            }
        }
    }
}