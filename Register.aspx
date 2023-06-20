<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="DB_demo4.Register" %>

<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Register</h2>
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
               <label for="password" class="form-label">Confirm Password:</label>
               <input type="password" runat="server" class="form-control" id="password1">
            </div>
            <div>
                <ASP:Button type="button" runat="server" class="btn btn-primary" Text="注册" OnClick="RegisterForm"></ASP:Button>
                <ASP:Button type="button" runat="server" class="btn btn-secondary" Text="重置" OnClick="Reset"></ASP:Button>
                &nbsp;&nbsp;
                <ASP:Button type="button" runat="server" class="btn btn-secondary" Text="返回登录界面" OnClick="ReturnLogin"></ASP:Button>
            </div>
            <div id="errorMessage" class="mt-3">
                <asp:Label ID="label" runat="server" Text="" Width=344px> </asp:Label>
            </div>
        </form>
    </div>
</body>
</html>

