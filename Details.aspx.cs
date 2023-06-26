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
            if (!IsPostBack)
            {
                spot.DataBind();
                year.DataBind();
                Chart1.DataBind();
            

                string ssId = Request.QueryString["SS_id"];
                imgSpot.ImageUrl = "~/img/" + ssId + ".jpg";
                string strcon = ConfigurationManager.ConnectionStrings["mydbConnectionString"].ConnectionString;//从web.config文件中读取连接字符串
                SqlConnection con = new SqlConnection(strcon);//定义连接对象
                SqlCommand cmd = new SqlCommand();//创建命令对象
                cmd.Connection = con;//设置命令对象的数据库连接属性

                //this.label.Text = this.password.ToString();
                cmd.CommandText = "SELECT * FROM view_allspot_mes WHERE (SS_id = @SS_id)";
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
                    Session["sname"] = this.lblSpotName.Text;
                    spot.SelectedValue = sdr["SS_id"].ToString();   // 图表绑定
                    Session["scity"] = this.lblCity.Text;
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
                    string query = "SELECT * FROM view_merchant";
                    cmd.CommandText = query;
                    SqlDataReader reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        string merchantID = reader["Mc_id"].ToString().PadLeft(5, '0');
                        string name = reader["Mcname"].ToString();
                        string type = reader["Mctype"].ToString();
                        string phone = reader["Mcphone"].ToString();
                        string longitude = reader["Mclocate_longitude"].ToString();
                        string latitude = reader["Mclocate_latitude"].ToString();
                        string startTime = reader["Mopen_start_time"].ToString();
                        string endTime = reader["Mopen_end_time"].ToString();

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
        }

        protected void spot_SelectedIndexChanged(object sender, EventArgs e)
        {
            year.DataBind(); // 重新绑定 year 下拉列表的数据源

        }
        protected void year_SelectedIndexChanged(object sender, EventArgs e)
        {
            Chart1.DataBind(); // 重新绑定 year 下拉列表的数据源

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