<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Me.aspx.cs" Inherits="DB_demo4.Me" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>我的</title>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            <a class="nav-link" href="FeedBacks.aspx" >用户反馈</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="#">我</a>
          </li>
          <li class="nav-item">
             <a class="nav-link" href="Login.aspx">注销</a>
        </li>
        </ul>
      </div>
    </div>
  </nav>
    <form id="form1" runat="server">

      <%-- 我的个人信息 --%>
    <div id="myProfile" class="container content">

         <div class="container mt-5">
            <div class="card">
                <h5 class="card-header">我的个人信息</h5>
                <div class="card-body">
                    <div class="form-group">
                        <label>用户名:</label>
                        <asp:Label ID="lblUsername" runat="server" CssClass="form-control" ClientIDMode="Static" ReadOnly="true"></asp:Label>
                    </div>
                    <div class="form-group" runat="server" id="divOldPassword" style="display:block;">
                        <label>旧密码:</label>
                        <asp:TextBox ID="txtOldPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group" runat="server" id="divNewPassword" style="display:none;">
                        <label>新密码:</label>
                        <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group" runat="server" id="divConfirmPassword" style="display:none;">
                        <label>确认新密码:</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    </div>

                    <asp:Button ID="Button1" runat="server" Text="修改密码" CssClass="btn btn-primary" OnClick="btnChangePassword_Click" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mt-3"></asp:Label>
                 </div>
            </div>
        </div>
    </div>
    </form>
     <script>
         // 在文档加载完成后进行事件绑定
         document.addEventListener('DOMContentLoaded', function () {
             // 获取旧密码输入框
             var txtOldPassword = document.getElementById('<%= txtOldPassword.ClientID %>');

            // 添加输入事件监听器
            txtOldPassword.addEventListener('input', function () {
                // 获取输入的旧密码值
                var oldPassword = txtOldPassword.value.trim();

                // 检查旧密码是否正确
                // 此处应使用Ajax请求到服务器验证旧密码的逻辑

                var sessionPassword = '<%= Session["pass"] %>';

                // 示例：当旧密码为'123456'时，显示新密码输入框，否则隐藏新密码输入框
                var divNewPassword = document.getElementById('<%= divNewPassword.ClientID %>');
                if (oldPassword === sessionPassword) {
                    divOldPassword.style.display = 'none';
                    divNewPassword.style.display = 'block';
                    divConfirmPassword.style.display = 'block';
                } else {
                    divNewPassword.style.display = 'none';
                    divConfirmPassword.style.display = 'none';
                }
            });
        });
     </script>
 


        <!-- 在此处添加显示我的个人信息的内容 -->

</body>
</html>