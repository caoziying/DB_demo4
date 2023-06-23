using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DB_demo4
{
    public partial class path : System.Web.UI.Page
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
        }
        protected void rets(object sender, EventArgs e)
        {
            Response.Redirect("Search.aspx");
        }
    }
}