<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="main.aspx.cs" Inherits="DB_demo4.main" %>
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
            <a class="nav-link active" href="#">首页</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Search.aspx">景点信息查询</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="My.aspx">我的</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <div class="container mt-4">
    <div class="jumbotron">
      <h1 class="display-4">欢迎来到旅游信息查询系统</h1>
      <p class="lead">这是一个用于查询旅游信息的系统，可以查询景点、预约景点与评价景点等信息。</p>
      <hr class="my-4">
      <p>开始使用系统，请选择上方导航栏中的相应功能。</p>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- 公示栏 -->
<footer class="bg-light py-5" style="background-color:blanchedalmond">
  <div class="container">
    <div class="row">
      <div class="col-lg-6 mx-auto text-center">
        <h3 class="mb-4" style="font-family:STSong;font-weight:800">公示栏</h3>
        <p><asp:Label ID="Ncontent" runat="server"></asp:Label></p>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12 text-end">
        <h7 class="mb-4" style="position: absolute; bottom: 40; right: 10; font-family: STSong; font-weight: 800;">
          <asp:Label ID="Mname" runat="server"></asp:Label>
        </h7>
      </div>
    </div>
  </div>
</footer>
    <asp:Label ID="yourLabel" runat="server"></asp:Label>

</body>

</html>

