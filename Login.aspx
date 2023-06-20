<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DB_demo4.WebForm1" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Login</h2>
        <form id="form1" runat="server">
            <div class="mb-3">
                <label for="username" class="form-label">Username:</label>
                <input type="text" runat="server" class="form-control" id="username">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" runat="server" class="form-control" id="password">
            </div>
            <div class="mb-3">
                <label for="userType" class="form-label">User Type:</label>
                <select class="form-select" runat="server" id="userType">
                    <option value="normal">Normal User</option>
                    <option value="admin">Admin User</option>
                </select>
            </div>
            <div>
                <ASP:Button type="button" runat="server" class="btn btn-primary" Text="登录" OnClick="login"></ASP:Button>
                <ASP:Button type="button" runat="server" class="btn btn-secondary" Text="重置" OnClick="resetForm"></ASP:Button>
                &nbsp;&nbsp;
                <Asp:Button ID="Button1" runat="server" class="btn btn-secondary" Text="注册新用户" OnClick="Register"/>
            </div>
            <div id="errorMessage" class="mt-3">
                <asp:Label ID="label" runat="server" Text="" Width=344px> </asp:Label>
            </div>
        </form>
    </div>
</body>
</html>
