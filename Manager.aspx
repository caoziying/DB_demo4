<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manager.aspx.cs" Inherits="DB_demo4.manager" %>

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
            <a class="nav-link" href="Me.aspx">我</a>
          </li>
          <li class="nav-item">
             <a class="nav-link" href="Login.aspx">注销</a>
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

</body>

</html>
