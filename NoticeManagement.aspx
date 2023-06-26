<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeManagement.aspx.cs" Inherits="DB_demo4.NoticeManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>系统公告</title>
    <!-- 引入 Bootstrap 样式表 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
</head>
<body>
          <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
              <a class="navbar-brand" href="#">旅游信息管理系统</a>
              <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                  <li class="nav-item">
                    <a class="nav-link" href="Manager.aspx">首页</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="UserManagement.aspx" >用户管理</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="SpotManagement.aspx" >景点管理</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="MerchantManagement.aspx" >商户管理</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link  active" href="#" >公告栏</a>
                  </li>
                    <li class="nav-item">
                    <a class="nav-link" href="FeedBacks.aspx" >用户反馈</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="Me.aspx">我</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link" href="Login.aspx">注销</a>
                  </li>
                </ul>
              </div>
            </div>
          </nav>
    <form id="form1" runat="server">
        <div>
            <div class="card">
                <div class="card-body">

                    <div class="form-group">
                        <label style="font-size:20px;font-weight:800;">发布公告:</label>
                        <asp:TextBox ID="txtNotice" runat="server" TextMode="MultiLine" CssClass="form-control" Height="260"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnSubmitNotice" runat="server" Text="提交" CssClass="btn btn-primary" OnClick="btnSubmitNotice_Click" Width="100px"/>
                     <asp:Label ID="lblMessage1" runat="server" CssClass="text-danger mt-3"></asp:Label>
                    
                </div>
            </div>
        </div>
        <div>
            <p>
                <asp:Label id="nums" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label>
            </p>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="N_id" DataSourceID="SqlDataSource1" Width="1300px">
                <Columns>
                    <asp:BoundField DataField="N_id" HeaderText="序号" InsertVisible="False" ReadOnly="True" SortExpression="N_id" />
                    <asp:BoundField DataField="M_id" HeaderText="管理员编号" SortExpression="M_id" />
                    <asp:BoundField DataField="Mname" HeaderText="管理员用户名" SortExpression="Mname" />
                    <asp:BoundField DataField="Ncontent" HeaderText="公告内容" SortExpression="Ncontent" />
                    <asp:BoundField DataField="Ntime" HeaderText="发布时间" SortExpression="Ntime" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" SelectCommand="SELECT Notice.N_id, Notice.M_id, Manager.Mname, Notice.Ncontent, Notice.Ntime FROM Notice INNER JOIN Manager ON Notice.M_id = Manager.M_id"></asp:SqlDataSource>
        </div>
    </form>
</body>
</html>
