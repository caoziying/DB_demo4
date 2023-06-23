<%@ Import Namespace="DB_demo4" %>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="DB_demo4.Search" %>
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
                <a class="nav-link" href="main.aspx">返回首页</a>
              </li>
              <li class="nav-item">
                <a class="nav-link active" href="#" >查询</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="Order.aspx">预约</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="PersonPage.aspx">我</a>
            </ul>
          </div>
        </div>
      </nav>




    <form id="form1" runat="server">
        <div class="container">
            <h1>旅游信息查询</h1>
            <div class="form-group">
                <label for="txtKeyword">关键词：</label>
                <input type="text" id="txtKeyword" runat="server" class="form-control" />
            </div>
            <div class="form-group">
                <asp:Button ID="btnSearch" runat="server" Text="搜索" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                <div style="float: right;">
                    <asp:Button ID="showRoute" runat="server" Text="显示行程" CssClass="btn btn-primary" OnClick="showRoute_Click"/>
                    <asp:Button ID="createRoutePath" runat="server" Text="生成路线" OnClick="showPath_Click" CssClass="btn btn-primary"/>
                </div>
            </div>




            <div class="form-group">
                <label for="ddlLocation">地理位置：</label>
                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-control">
                    <asp:ListItem Text="全部" Value="" />
                    <asp:ListItem Text="北京" Value="北京" />
                    <asp:ListItem Text="上海" Value="上海" />
                    <asp:ListItem Text="广州" Value="广州" />
                    <asp:ListItem Text="宣城" Value="宣城" />
                    
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <asp:Button ID="btnFilter" runat="server" Text="筛选" CssClass="btn btn-primary" OnClick="btnFilter_Click" />
            </div>
            <!-- 显示查询结果的表格 -->

            <asp:GridView ID="gvResults" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="False" DataKeyNames="SS_id">
                <Columns>
                    <asp:BoundField DataField="SS_id" HeaderText="景点编号" Visible="false"/>
                    <asp:HyperLinkField DataTextField="SSname" DataNavigateUrlFields="SS_id" DataNavigateUrlFormatString="Details.aspx?SS_id={0}" HeaderText="景点名称" HeaderStyle-Width="200px" SortExpression="SSname" />
                    <asp:BoundField DataField="SScity" HeaderText="位置" />
                    <asp:BoundField DataField="SSopen_start_time" HeaderText="开放时间" />
                    <asp:BoundField DataField="SSopen_end_time" HeaderText="关闭时间" />
                    <asp:BoundField DataField="SSphone" HeaderText="联系方式" />
                    <asp:BoundField DataField="SScap_res" HeaderText="剩余票数" />
                    <asp:TemplateField HeaderText="添加到行程" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Button ID="btnAddToItinerary" runat="server" Text="Add" CssClass="btn btn-sm btn-secondary" OnClick="btnAddToItinerary_Click" CommandArgument='<%# Eval("SS_id") %>'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="查看详情" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center" >
                        <ItemTemplate>
                            <asp:Button ID="btnShowDetail" runat="server" Text="Detail" OnClick="btnShowDetail_Click" CssClass="btn btn-sm btn-dark" CommandArgument='<%# Eval("SS_id") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>

                </Columns>
            </asp:GridView>
            
            <!-- 存储点击查看行的SS_id -->
            <asp:HiddenField ID="hidSSId" runat="server" />

            <%-- 悬浮窗 显示某一景点具体信息 --%>
            <div id="popupContainer" class="popupContainer" runat="server" Visible="false">
                <div class="popupContent">
                    <div class="popupHeader">

                        <h3 class="popupTitle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            详细信息</h3>
                        <div class="closeButtonContainer">
                            <asp:Button ID="btnClosePopup" runat="server" Text="退出" OnClick="btnClosePopup_Click" CssClass="btn btn-sm btn-primary rounded" />
                        </div>
                    </div>
                    <asp:DetailsView ID="detailsView" runat="server" CssClass="detailsView" AutoGenerateRows="False" DataKeyNames="SS_id" DataSourceID="SqlDataSource1">
                        <Fields>
                            <asp:BoundField DataField="SS_id" HeaderText="SS_id" HeaderStyle-Width="200px" ReadOnly="True" SortExpression="SS_id" Visible="false"/>
                            <asp:BoundField DataField="SSname" HeaderText="景点名称" HeaderStyle-Width="200px" SortExpression="SSname" />
                            <asp:BoundField DataField="SScity" HeaderText="所在城市" SortExpression="SScity" />
                            <asp:BoundField DataField="SSlocate_longitude" HeaderText="SSlocate_longitude" SortExpression="SSlocate_longitude" Visible="false"/>
                            <asp:BoundField DataField="SSlocate_latitude" HeaderText="SSlocate_latitude" SortExpression="SSlocate_latitude" Visible="false"/>
                            <asp:BoundField DataField="Price" HeaderText="门票价格" SortExpression="SSprice" />
                            <asp:BoundField DataField="SSrate" HeaderText="折扣" SortExpression="SSrate" Visible="false"/>
                            <asp:BoundField DataField="SSphone" HeaderText="联系电话" SortExpression="SSphone" />
                            <asp:BoundField DataField="SScap" HeaderText="SScap" SortExpression="SScap" Visible="false"/>
                            <asp:BoundField DataField="SScap_res" HeaderText="剩余票数" SortExpression="SScap_res" />
                            <asp:BoundField DataField="SSopen_start_time" HeaderText="开门时间" SortExpression="SSopen_start_time" />
                            <asp:BoundField DataField="SSopen_end_time" HeaderText="关门时间" SortExpression="SSopen_end_time" />
                            <asp:BoundField DataField="IsInfo" HeaderText="详情" SortExpression="IsInfo" />
                        </Fields>
                    </asp:DetailsView>

                    <div class="popupFooter">
                        <asp:Button ID="btnReserve" runat="server" Text="预约" CssClass="btn btn-sm btn-primary rounded" OnClick="btnReserve_Click" />
                        <asp:Button ID="btnRate" runat="server" Text="评价" CssClass="btn btn-sm btn-primary rounded" OnClick="btnRate_Click" />
                    </div>

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" SelectCommand="SELECT ScenicSpot.SS_id, ScenicSpot.SSname, ScenicSpot.SScity, ScenicSpot.SSlocate_longitude, ScenicSpot.SSlocate_latitude, ScenicSpot.SSprice, ScenicSpot.SSrate, CASE WHEN ScenicSpot.SSphone IS NULL THEN '暂无联系方式' ELSE ScenicSpot.SSphone END AS SSphone, ScenicSpot.SScap, ScenicSpot.SScap_res, CASE WHEN ScenicSpot.SSopen_start_time IS NULL THEN '00:00:00' ELSE CONVERT (VARCHAR(8) , ScenicSpot.SSopen_start_time , 108) END AS SSopen_start_time, CASE WHEN ScenicSpot.SSopen_end_time IS NULL THEN '24:00:00' ELSE CONVERT (VARCHAR(8) , ScenicSpot.SSopen_end_time , 108) END AS SSopen_end_time, InfoSpot.IsInfo, ScenicSpot.SSprice * ScenicSpot.SSrate AS Price FROM ScenicSpot INNER JOIN InfoSpot ON ScenicSpot.SS_id = InfoSpot.SS_id WHERE (ScenicSpot.SS_id = @SS_id)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="hidSSId" Name="SS_id" PropertyName="Value" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>

                </div>
            </div>

            <style>
                .popupContainer {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0, 0, 0, 0.5);
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
               .popupHeader {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }
               .popupTitle {
                    margin: 0;
                    text-align: center;
                }
                .closeButtonContainer {
                    margin-left: auto;
                }
                .popupContent {
                    background-color: #fff;
                    padding: 20px;
                    max-width: 800px;
                    text-align: center;
                }

                .detailsView {
                    margin-bottom: 20px;
                }
                .exit-button {
                  border: none;
                  background-color: transparent;
                  font-size: 1.2rem;
                  padding: 0;
                  margin: 0;
                  line-height: 1;
                  cursor: pointer;
                  color: #333;
                }

                .exit-button:focus {
                  outline: none;
                }

            </style>

        </div>
    </form>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
</body>


</html>


