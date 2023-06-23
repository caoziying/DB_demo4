<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonPage.aspx.cs" Inherits="DB_demo4.PersonPage" EnableEventValidation="false"%>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>旅游信息管理系统</title>
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
            <a class="nav-link" href="main.aspx">返回首页</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Search.aspx" >查询</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Order.aspx">预约</a>
          </li>
          <li class="nav-item">
            <a class="nav-link active" href="#">我</a>
        </ul>
      </div>
    </div>
  </nav>

     <nav class="navbar navbar-expand-md bg-dark navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">我</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#myTrips">我的行程</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#myAppointments">我的预约</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#myProfile">我的个人信息</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>


      <%-- 我的行程 --%>
    <div id="myTrips" class="container content">
        <asp:GridView ID="gvMyTrips" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="False" DataKeyNames="Id">
            <Columns>
                <asp:TemplateField HeaderText="序号">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:BoundField DataField="Id" HeaderText="编号" />--%>
                <asp:BoundField DataField="Name" HeaderText="名称" />
                <asp:BoundField DataField="Type" HeaderText="类型" />
                <asp:BoundField DataField="OpenStartTime" HeaderText="开放时间" />
                <asp:BoundField DataField="OpenEndTime" HeaderText="关闭时间" />
                <asp:BoundField DataField="Phone" HeaderText="联系方式" />
                <asp:BoundField DataField="Cap_res" HeaderText="剩余票数" />
                <asp:TemplateField HeaderText="删除行程" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Button ID="btnDeleteFromItinerary" runat="server" Text="Delete" CssClass="btn btn-sm btn-secondary" OnClick="btnDeleteFromItinerary_Click" CommandArgument='<%# Eval("Id") + "," + Eval("Type") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
            </Columns>
        </asp:GridView>

    </div>

      <%-- 我的预约 --%>
    <div id="myAppointments" class="container content">
        <h2>我的预约</h2>
        <!-- 在此处添加显示我的预约的内容 -->
    </div>

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
                        <select id="ddlFeedbackType" class="form-control"  runat="server">
                            <option value="功能请求">功能请求</option>
                            <option value="缺陷报告">缺陷报告</option>
                            <option value="用户界面反馈">用户界面反馈</option>
                            <option value="性能问题">性能问题</option>
                            <option value="安全问题">安全问题</option>
                            <option value="文档和帮助反馈">文档和帮助反馈</option>
                            <option value="用户体验反馈">用户体验反馈</option>
                        </select>
                    </div>
                    <div class="form-group">
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
    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(document).ready(function () {
            // 获取 URL 中的锚点
            var hash = window.location.hash;
            if (!hash) hash = "#myProfile";
            // 如果存在锚点
            if (hash) {
                // 移除所有选项的激活状态
                $(".nav-link").removeClass("active");

                // 将对应锚点的选项设置为激活状态
                $('a[href="' + hash + '"]').addClass("active");

                // 显示对应锚点的内容区域
                $(hash).show();
            }

            // 监听导航栏链接的点击事件
            $(".nav-link").on("click", function () {
                var target = $(this).attr("href"); // 获取目标内容区域的ID

                // 隐藏所有内容区域
                $(".content").hide();

                // 显示目标内容区域
                $(target).show();

                // 页面跳转到目标链接
                window.location.href = target;

                return false; // 阻止链接的默认行为
            });
        });
    </script>

    
    <%--  子目录  --%>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const navLinks = document.querySelectorAll(".nav-link");

            navLinks.forEach(function (link) {
                link.addEventListener("click", function (event) {
                    event.preventDefault();

                    // 移除所有链接的激活类
                    navLinks.forEach(function (link) {
                        link.classList.remove("active");
                    });

                    // 将点击的链接添加激活类
                    this.classList.add("active");

                    // 获取目标内容区域的 ID
                    const target = this.getAttribute("href");
                    
                    // 隐藏所有内容区域
                    const contentElements = document.querySelectorAll(".content");
                    contentElements.forEach(function (content) {
                        content.style.display = "none";
                    });

                    // 显示目标内容区域
                    document.querySelector(target).style.display = "block";

                    // 平滑滚动到目标内容区域
                    document.querySelector(target).scrollIntoView({
                        behavior: "smooth"
                    });
                    // 返回 false 阻止链接的默认行为
                    return true;
                });
            });
        });
    </script>



    <style>
    .content {
        display: none; /* 默认隐藏所有内容区域 */
    }
    </style>
  </form>
</body>


</html>