<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="DB_demo4.UserManagement" %>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>旅游信息管理系统</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
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
            <a class="nav-link active" href="#" >用户管理</a>
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
          
          <div class="container">
            <div class="row mb-3">
              <div class="col">
                  <p>
                      <asp:Label id="nums" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label>
                  </p>
                <h1>用户管理</h1>
              </div>
            </div>

            <!-- 查询表单 -->
            <asp:Panel ID="searchPanel" runat="server">
                <div class="form-group">
                    <label for="name">用户名：</label>
                    <input type="text" class="form-control" id="name" runat="server" />
                </div>
                <asp:button runat="server" type="submit" class="btn btn-primary" onclick="SearchUser_Click" Text="查询"></asp:button>
            </asp:Panel>

            <!-- 用户列表 -->
            <asp:GridView ID="userTable" runat="server" CssClass="table table-bordered"
                AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Uname" HeaderText="用户名" />
                    <asp:BoundField DataField="Upass" HeaderText="密码" />

                </Columns>
            </asp:GridView>
        </div>
        </form>
</body>
     <script>
        function SearchUser_Click() {
            // 获取用户名输入框的值
            var username = document.getElementById("name").value;

            // 使用 AJAX 请求向后端发送查询请求
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    // 处理查询结果
                    var response = JSON.parse(this.responseText);
                    // TODO: 根据查询结果进行相应处理，例如刷新用户列表或显示查询结果等
                }
            };
            xhttp.open("GET", "UserManagement.aspx?username=" + encodeURIComponent(username), true);
            xhttp.send();
        }
     </script>
</html>
