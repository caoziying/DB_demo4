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
    public partial class Details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["username"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            string ssId = Request.QueryString["SS_id"];
            imgSpot.ImageUrl = "~/img/" + ssId + ".jpg";
            string strcon = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString; ;//从web.config文件中读取连接字符串
            SqlConnection con = new SqlConnection(strcon);//定义连接对象
            SqlCommand cmd = new SqlCommand();//创建命令对象
            cmd.Connection = con;//设置命令对象的数据库连接属性

            //this.label.Text = this.password.ToString();
            cmd.CommandText = "SELECT ScenicSpot.SS_id, ScenicSpot.SSname, ScenicSpot.SScity, ScenicSpot.SSlocate_longitude, ScenicSpot.SSlocate_latitude, ScenicSpot.SSprice, ScenicSpot.SSrate, CASE WHEN ScenicSpot.SSphone IS NULL THEN '暂无联系方式' ELSE ScenicSpot.SSphone END AS SSphone, ScenicSpot.SScap, ScenicSpot.SScap_res, CASE WHEN ScenicSpot.SSopen_start_time IS NULL THEN '00:00:00' ELSE CONVERT (VARCHAR(8) , ScenicSpot.SSopen_start_time , 108) END AS SSopen_start_time, CASE WHEN ScenicSpot.SSopen_end_time IS NULL THEN '24:00:00' ELSE CONVERT (VARCHAR(8) , ScenicSpot.SSopen_end_time , 108) END AS SSopen_end_time, InfoSpot.IsInfo, ScenicSpot.SSprice * ScenicSpot.SSrate AS Price FROM ScenicSpot,InfoSpot WHERE ScenicSpot.SS_id = InfoSpot.SS_id AND (ScenicSpot.SS_id = @SS_id)";
            cmd.Parameters.AddWithValue("@SS_id", ssId);


            con.Open();//打开数据库连接
                       //Response.Write("连接数据库查询成功");
            try
            {
                SqlDataReader sdr = cmd.ExecuteReader();//执行SQL命令，并获取查询结果

                sdr.Read();
                this.lblSpotName.Text = sdr["SSname"].ToString();
                this.lblCity.Text = sdr["SScity"].ToString();
                this.lblPrice.Text = "原价：" + sdr["SSprice"].ToString() + "\t折扣：" + sdr["SSrate"].ToString() + "\t现价：" + (float.Parse(sdr["SSprice"].ToString()) * float.Parse(sdr["SSrate"].ToString())).ToString();
                this.lblOpentime.Text = sdr["SSopen_start_time"].ToString() + "--" + sdr["SSopen_end_time"].ToString();
                this.lblPhone.Text = sdr["SSphone"].ToString();
                this.lblInfo.Text = sdr["IsInfo"].ToString();
                string currentLongitude = sdr["SSlocate_longitude"].ToString();
                string currentLatitude = sdr["SSlocate_latitude"].ToString();
                Session["pre_lng"] = currentLongitude;
                Session["pre_lat"] = currentLatitude;
                //this.lblMerchant.Text = DistanceCalculator.CalculateDistance("118.72640", "30.98427", "118.76036", "30.92957").ToString() + "km";

                // 创建DataTable用于存储商户
                DataTable merchantTable = new DataTable();
                merchantTable.Columns.Add("Mc_id", typeof(int));
                merchantTable.Columns.Add("Mcname", typeof(string));
                merchantTable.Columns.Add("Mctype", typeof(string));
                merchantTable.Columns.Add("Mdistance", typeof(string));
                merchantTable.Columns.Add("Mcphone", typeof(string));
                merchantTable.Columns.Add("Mclocate_longitude", typeof(string));
                merchantTable.Columns.Add("Mclocate_latitude", typeof(string));
                merchantTable.Columns.Add("Mopen_start_time", typeof(string));
                merchantTable.Columns.Add("Mopen_end_time", typeof(string));


                sdr.Close();
                // 从Merchant表中获取所有商户
                string query = "SELECT * FROM Merchant";
                cmd.CommandText = query;
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    string merchantID = reader["Mc_id"].ToString().PadLeft(5, '0');
                    string name = reader["Mcname"].ToString();
                    string type = "";
                    if (reader["Mctype"].ToString().Equals("00"))
                        type = "住宿";
                    else if(reader["Mctype"].ToString().Equals("01"))
                        type = "餐饮";
                    string phone = reader["Mcphone"].ToString().Length==0?"暂无联系方式": reader["Mcphone"].ToString();
                    string longitude = reader["Mclocate_longitude"].ToString();
                    string latitude = reader["Mclocate_latitude"].ToString();
                    string startTime = reader["Mopen_start_time"].ToString().Length == 0 ?"00:00:00": reader["Mopen_start_time"].ToString();
                    string endTime = reader["Mopen_end_time"].ToString().Length == 0 ? "24:00:00": reader["Mopen_end_time"].ToString();

                    // 使用距离计算函数计算商户与给定经纬度之间的距离
                    double distance = DistanceCalculator.CalculateDistance(latitude, longitude, currentLatitude, currentLongitude);

                    // 如果距离小于5公里，则将商户添加到DataTable中
                    if (distance < 5)
                    {
                        merchantTable.Rows.Add(merchantID, name, type, distance.ToString("F2") + "km", phone, longitude, latitude, startTime, endTime);
                    }
                }
                // 按距离升序排序 DataTable
                DataView sortedView = merchantTable.DefaultView;
                sortedView.Sort = "Mdistance ASC";
                DataTable sortedTable = sortedView.ToTable();

                merchants.DataSource = sortedTable;
                merchants.DataBind();

            }
            catch (SqlException ex)
            {
                ClientScript.RegisterStartupScript(GetType(), "alert", "alert('出现异常，查询失败！');", true);
            }
            finally
            {
                con.Close(); // Close the database connection
            }
        }

        protected void btnAddToItinerary_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            // 获取按钮的CommandArgument，即景点编号
            string mcId = btn.CommandArgument.PadLeft(5, '0');

            // 判断Session中是否存在相同内容
            if (Session["TempFormData"] == null)
            {
                // 如果Session为空，则创建新的列表并将数据存入其中
                List<string> tempFormList = new List<string>();
                tempFormList.Add(mcId.PadLeft(5, '0'));

                // 将列表存入Session
                Session["TempFormData"] = tempFormList;
            }
            else
            {
                // 如果Session已存在，则检查是否存在相同内容
                List<string> tempFormList = (List<string>)Session["TempFormData"];
                if (!tempFormList.Contains(mcId.PadLeft(5, '0')))
                {
                    // 不存在相同的景点编号，将新的景点编号添加到列表中
                    tempFormList.Add(mcId.PadLeft(5, '0'));

                    // 更新会话中的临时数据列表
                    Session["TempFormData"] = tempFormList;
                }
            }
        }

        protected void retPre(object sender, EventArgs e)
        {
            Response.Redirect("Search.aspx");
        }
    }
}