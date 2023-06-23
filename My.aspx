<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="My.aspx.cs" Inherits="DB_demo4.My" %>

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
    <form id="form1" runat="server">
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
            <a class="nav-link" href="main.aspx">首页</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Search.aspx">景点信息查询</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="#">我的</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
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
            <br />
            <br />
            <div class="card">
                <div class="card-body">
                     
                    <div class="form-group">
                        <label>选择反馈类型:</label>
                        <select id="ddlFeedbackType" class="form-control" runat="server">
                            <option value="功能请求">功能请求</option>
                            <option value="缺陷报告">缺陷报告</option>
                            <option value="用户界面反馈">用户界面反馈</option>
                            <option value="性能问题">性能问题</option>
                            <option value="安全问题">安全问题</option>
                            <option value="文档和帮助反馈">文档和帮助反馈</option>
                            <option value="用户体验反馈">用户体验反馈</option>
                        </select>
                        <label>提交反馈给管理员:</label>
                        <asp:TextBox ID="txtFeedback" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnSubmitFeedback" runat="server" Text="提交" CssClass="btn btn-primary" OnClick="btnSubmitFeedback_Click" Width="100px"/>
                    <asp:Label ID="lblMessage1" runat="server" CssClass="text-danger mt-3"></asp:Label>
                    
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

                var sessionPassword = '<%= Session["password"] %>';

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
