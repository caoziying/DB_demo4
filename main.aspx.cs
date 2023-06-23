using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
//using System.Text.Json;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_demo4
{
    public partial class main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (Session["TempFormData"] != null)
            {
                List<string> list = (List<string>)Session["TempFormData"];
                
                

                // 使用 StringBuilder 构建 HTML 标签
                StringBuilder htmlBuilder = new StringBuilder();
                foreach (string item in list)
                {
                    htmlBuilder.Append(" ").Append(item).Append("|");
                }
                //if(Session["LongitudeList"]!=null)
                //{
                //    List<string> list1 = (List<string>)JsonConvert.DeserializeObject(Session["LongitudeList"]);
                //    foreach (string item in list1)
                //    {
                //        htmlBuilder.Append(" ").Append(item).Append("|");
                //    }
                //}else
                //{
                //    htmlBuilder.Append(" ").Append("LongitudeList is null").Append("|");
                //}
                //if (Session["LatitudeList"] != null)
                //{
                //    List<string> list2 = (List<string>)Session["LatitudeList"];
                //    foreach (string item in list2)
                //    {
                //        htmlBuilder.Append(" ").Append(item).Append("|");
                //    }
                //}
                //else
                //{
                //    htmlBuilder.Append(" ").Append("LatitudeList is null").Append("|");
                //}
                // 将生成的 HTML 标签赋值给 Label 的 Text 属性
                yourLabel.Text = htmlBuilder.ToString();
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


            if (Session["TempFormData"] != null)
            {
                List<string> tempFormDataList = (List<string>)Session["TempFormData"];
                string con = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;
                SqlConnection connect = new SqlConnection(con);

                // 创建DataTable用于存储用户表和商户表内容
                DataTable tempTable = new DataTable();
                tempTable.Columns.Add("Id", typeof(int));
                tempTable.Columns.Add("Name", typeof(string));
                tempTable.Columns.Add("Type", typeof(string));
                tempTable.Columns.Add("OpenStartTime", typeof(string));
                tempTable.Columns.Add("OpenEndTime", typeof(string));
                tempTable.Columns.Add("Phone", typeof(string));
                tempTable.Columns.Add("Cap_res", typeof(string));

                try
                {
                    // 构建查询语句和参数
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
                    string query = queryBuilder.ToString();
                    SqlCommand cmd = new SqlCommand(query, connect);
                    cmd.Parameters.AddRange(parameters.ToArray());

                    // 打开数据库连接
                    connect.Open();

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
                        tempTable.Rows.Add(id.PadLeft(4, '0'), name, type, startTime, endTime, phone, cap_res);
                    }

                    sdr.Close();

                    /* 商户查询 */
                    // 构建查询语句和参数
                    StringBuilder queryBuilder1 = new StringBuilder();
                    queryBuilder1.Append("SELECT Mc_id, Mcname, Mctype, Mclocate_longitude, Mclocate_latitude, CASE WHEN Mcphone IS NULL THEN '暂无联系方式' ELSE Mcphone END AS Mcphone, CASE WHEN Mopen_start_time IS NULL THEN '00:00:00' ELSE CONVERT(VARCHAR(8), Mopen_start_time, 108) END AS Mopen_start_time, CASE WHEN Mopen_end_time IS NULL THEN '24:00:00' ELSE CONVERT(VARCHAR(8), Mopen_end_time, 108) END AS Mopen_end_time FROM Merchant WHERE Mc_id IN (");

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
                    SqlCommand cmd1 = new SqlCommand(query1, connect);
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
                        tempTable.Rows.Add(id.PadLeft(5, '0'), name, type, startTime, endTime, phone, cap_res);
                    }


                    // 排序
                    // 假设tempTable是你原始的DataTable对象
                    // 假设tempFormDataList是存储ID序列的List<string>对象

                    // 创建一个新的DataTable来存储重新排序后的元组
                    DataTable sortedTable = tempTable.Clone();

                    // 使用LINQ按照tempFormDataList中的ID顺序重新排序元组
                    var sortedRows = tempFormDataList.Select(id => tempTable.Select($"id = '{id}'")).SelectMany(row => row);

                    // 将排序后的元组添加到新的DataTable中
                    foreach (var row in sortedRows)
                    {
                        sortedTable.ImportRow(row);
                    }

                    /*               取出经纬度              */
                    // 创建一个匿名对象的集合来存储经度和纬度
                    //var coordinatesList = new List<object>();
                    //foreach (DataRow row in sortedTable.Rows)
                    //{
                    //    string longitude = row["longitude"].ToString();
                    //    string latitude = row["latitude"].ToString();
                    //    var coordinates = new { Longitude = longitude, Latitude = latitude };
                    //    coordinatesList.Add(coordinates);
                    //}
                    //// 将经度和纬度集合转换为JSON格式
                    //string json = JsonSerializer.Serialize(coordinatesList);
                    //// 存储JSON数据到Session中
                    //Session["Coordinates"] = json;

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
            }
        }
    }


}