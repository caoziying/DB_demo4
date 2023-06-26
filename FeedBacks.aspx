<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedBacks.aspx.cs" Inherits="DB_demo4.FeedBacks" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>用户反馈</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"/>
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
                    <a class="nav-link" href="NoticeManagement.aspx" >公告栏</a>
                  </li>
                    <li class="nav-item">
                    <a class="nav-link active" href="#" >用户反馈</a>
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
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" CssClass="table table-bordered table-striped" >
                <Columns>
                    <asp:TemplateField HeaderText="序号">
                        <ItemTemplate>
                            <%# Container.DataItemIndex + 1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="U_id" HeaderText="用户编号" SortExpression="U_id" />
                    <asp:BoundField DataField="Uname" HeaderText="用户名" SortExpression="Uname" />
                    <asp:BoundField DataField="Ftype" HeaderText="反馈类型" SortExpression="Ftype" />
                    <asp:BoundField DataField="Fcontent" HeaderText="反馈内容" SortExpression="Fcontent" />
                    <asp:BoundField DataField="Ftime" HeaderText="反馈时间" SortExpression="Ftime" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" SelectCommand="SELECT Feedback.U_id, Users.Uname, Feedback.Ftype, Feedback.Fcontent, Feedback.Ftime FROM Feedback INNER JOIN Users ON Feedback.U_id = Users.U_id"></asp:SqlDataSource>
            <p><asp:Label id="num0" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label></p>
            <p><asp:Label id="num1" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label></p>
            <p><asp:Label id="num2" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label></p>
            <p><asp:Label id="num3" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label></p>
            <p><asp:Label id="num4" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label></p>
            <p><asp:Label id="num5" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label></p>
            <p><asp:Label id="num6" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label></p>
            <p><asp:Label id="num7" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label></p>
            <p><asp:Label id="num8" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label></p>
        </div>
    </form>
</body>
</html>
