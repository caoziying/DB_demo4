<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SpotManagement.aspx.cs" Inherits="DB_demo4.SpotManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>景点信息管理</title>
        <!-- 引入 Bootstrap 样式表 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
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
            <a class="nav-link  active" href="#" >景点管理</a>
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
        <div>
            <p>
                <asp:Label id="nums" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label>
            </p>
            <p>
                <asp:Label id="now" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label>
            </p>
            <p>
                <asp:Label id="nums2" runat="server" Text="" Font-Size="20px" Font-Bold="true"></asp:Label>
            </p>
            
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="SS_id" DataSourceID="SqlDataSource1" AllowSorting="True" CssClass="table table-bordered table-striped" AllowPaging="True" >
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="SS_id" HeaderText="景区编号" ReadOnly="True" SortExpression="SS_id" />
                    <asp:BoundField DataField="SSname" HeaderText="景区名称" SortExpression="SSname" />
                    <asp:BoundField DataField="SScity" HeaderText="所在城市" SortExpression="SScity" />
                    <asp:BoundField DataField="SSlocate_longitude" HeaderText="所在经度" SortExpression="SSlocate_longitude" />
                    <asp:BoundField DataField="SSlocate_latitude" HeaderText="所在纬度" SortExpression="SSlocate_latitude" />
                    <asp:BoundField DataField="SSprice" HeaderText="价格" SortExpression="SSprice" />
                    <asp:BoundField DataField="SSrate" HeaderText="折扣" SortExpression="SSrate" />
                    <asp:BoundField DataField="SSphone" HeaderText="联系电话" SortExpression="SSphone" />
                    <asp:BoundField DataField="SScap" HeaderText="总容量" SortExpression="SScap" />
                    <asp:BoundField DataField="SScap_res" HeaderText="剩余容量" SortExpression="SScap_res" />
                    <asp:BoundField DataField="SSopen_start_time" HeaderText="开门时间" SortExpression="SSopen_start_time" />
                    <asp:BoundField DataField="SSopen_end_time" HeaderText="关门时间" SortExpression="SSopen_end_time" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" DeleteCommand="DELETE FROM [ScenicSpot] WHERE [SS_id] = @original_SS_id AND [SSname] = @original_SSname AND [SScity] = @original_SScity AND [SSlocate_longitude] = @original_SSlocate_longitude AND [SSlocate_latitude] = @original_SSlocate_latitude AND (([SSprice] = @original_SSprice) OR ([SSprice] IS NULL AND @original_SSprice IS NULL)) AND (([SSrate] = @original_SSrate) OR ([SSrate] IS NULL AND @original_SSrate IS NULL)) AND (([SSphone] = @original_SSphone) OR ([SSphone] IS NULL AND @original_SSphone IS NULL)) AND (([SScap] = @original_SScap) OR ([SScap] IS NULL AND @original_SScap IS NULL)) AND (([SScap_res] = @original_SScap_res) OR ([SScap_res] IS NULL AND @original_SScap_res IS NULL)) AND (([SSopen_start_time] = @original_SSopen_start_time) OR ([SSopen_start_time] IS NULL AND @original_SSopen_start_time IS NULL)) AND (([SSopen_end_time] = @original_SSopen_end_time) OR ([SSopen_end_time] IS NULL AND @original_SSopen_end_time IS NULL))" InsertCommand="INSERT INTO [ScenicSpot] ([SS_id], [SSname], [SScity], [SSlocate_longitude], [SSlocate_latitude], [SSprice], [SSrate], [SSphone], [SScap], [SScap_res], [SSopen_start_time], [SSopen_end_time]) VALUES (@SS_id, @SSname, @SScity, @SSlocate_longitude, @SSlocate_latitude, @SSprice, @SSrate, @SSphone, @SScap, @SScap_res, @SSopen_start_time, @SSopen_end_time)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [ScenicSpot]" UpdateCommand="UPDATE [ScenicSpot] SET [SSname] = @SSname, [SScity] = @SScity, [SSlocate_longitude] = @SSlocate_longitude, [SSlocate_latitude] = @SSlocate_latitude, [SSprice] = @SSprice, [SSrate] = @SSrate, [SSphone] = @SSphone, [SScap] = @SScap, [SScap_res] = @SScap_res, [SSopen_start_time] = @SSopen_start_time, [SSopen_end_time] = @SSopen_end_time WHERE [SS_id] = @original_SS_id AND [SSname] = @original_SSname AND [SScity] = @original_SScity AND [SSlocate_longitude] = @original_SSlocate_longitude AND [SSlocate_latitude] = @original_SSlocate_latitude AND (([SSprice] = @original_SSprice) OR ([SSprice] IS NULL AND @original_SSprice IS NULL)) AND (([SSrate] = @original_SSrate) OR ([SSrate] IS NULL AND @original_SSrate IS NULL)) AND (([SSphone] = @original_SSphone) OR ([SSphone] IS NULL AND @original_SSphone IS NULL)) AND (([SScap] = @original_SScap) OR ([SScap] IS NULL AND @original_SScap IS NULL)) AND (([SScap_res] = @original_SScap_res) OR ([SScap_res] IS NULL AND @original_SScap_res IS NULL)) AND (([SSopen_start_time] = @original_SSopen_start_time) OR ([SSopen_start_time] IS NULL AND @original_SSopen_start_time IS NULL)) AND (([SSopen_end_time] = @original_SSopen_end_time) OR ([SSopen_end_time] IS NULL AND @original_SSopen_end_time IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_SS_id" Type="String" />
                    <asp:Parameter Name="original_SSname" Type="String" />
                    <asp:Parameter Name="original_SScity" Type="String" />
                    <asp:Parameter Name="original_SSlocate_longitude" Type="Decimal" />
                    <asp:Parameter Name="original_SSlocate_latitude" Type="Decimal" />
                    <asp:Parameter Name="original_SSprice" Type="Decimal" />
                    <asp:Parameter Name="original_SSrate" Type="Decimal" />
                    <asp:Parameter Name="original_SSphone" Type="String" />
                    <asp:Parameter Name="original_SScap" Type="Decimal" />
                    <asp:Parameter Name="original_SScap_res" Type="Decimal" />
                    <asp:Parameter DbType="Time" Name="original_SSopen_start_time" />
                    <asp:Parameter DbType="Time" Name="original_SSopen_end_time" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="SS_id" Type="String" />
                    <asp:Parameter Name="SSname" Type="String" />
                    <asp:Parameter Name="SScity" Type="String" />
                    <asp:Parameter Name="SSlocate_longitude" Type="Decimal" />
                    <asp:Parameter Name="SSlocate_latitude" Type="Decimal" />
                    <asp:Parameter Name="SSprice" Type="Decimal" />
                    <asp:Parameter Name="SSrate" Type="Decimal" />
                    <asp:Parameter Name="SSphone" Type="String" />
                    <asp:Parameter Name="SScap" Type="Decimal" />
                    <asp:Parameter Name="SScap_res" Type="Decimal" />
                    <asp:Parameter DbType="Time" Name="SSopen_start_time" />
                    <asp:Parameter DbType="Time" Name="SSopen_end_time" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="SSname" Type="String" />
                    <asp:Parameter Name="SScity" Type="String" />
                    <asp:Parameter Name="SSlocate_longitude" Type="Decimal" />
                    <asp:Parameter Name="SSlocate_latitude" Type="Decimal" />
                    <asp:Parameter Name="SSprice" Type="Decimal" />
                    <asp:Parameter Name="SSrate" Type="Decimal" />
                    <asp:Parameter Name="SSphone" Type="String" />
                    <asp:Parameter Name="SScap" Type="Decimal" />
                    <asp:Parameter Name="SScap_res" Type="Decimal" />
                    <asp:Parameter DbType="Time" Name="SSopen_start_time" />
                    <asp:Parameter DbType="Time" Name="SSopen_end_time" />
                    <asp:Parameter Name="original_SS_id" Type="String" />
                    <asp:Parameter Name="original_SSname" Type="String" />
                    <asp:Parameter Name="original_SScity" Type="String" />
                    <asp:Parameter Name="original_SSlocate_longitude" Type="Decimal" />
                    <asp:Parameter Name="original_SSlocate_latitude" Type="Decimal" />
                    <asp:Parameter Name="original_SSprice" Type="Decimal" />
                    <asp:Parameter Name="original_SSrate" Type="Decimal" />
                    <asp:Parameter Name="original_SSphone" Type="String" />
                    <asp:Parameter Name="original_SScap" Type="Decimal" />
                    <asp:Parameter Name="original_SScap_res" Type="Decimal" />
                    <asp:Parameter DbType="Time" Name="original_SSopen_start_time" />
                    <asp:Parameter DbType="Time" Name="original_SSopen_end_time" />
                </UpdateParameters>
            </asp:SqlDataSource>

        </div>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="SqlDataSource2" Height="50px" Width="1420px" DataKeyNames="SS_id" FieldHeaderStyle-Width="100" OnItemDeleted="DetailsView1_ItemDeleted" OnItemInserted="DetailsView1_ItemInserted">
            <Fields>
                <asp:BoundField DataField="SS_id" HeaderText="景点编号" SortExpression="SS_id" ReadOnly="True" />
                <asp:BoundField DataField="SSname" HeaderText="景点名称" SortExpression="SSname" />
                <asp:BoundField DataField="SScity" HeaderText="所在城市" SortExpression="SScity" />
                <asp:BoundField DataField="SSlocate_longitude" HeaderText="所在经度" SortExpression="SSlocate_longitude" />
                <asp:BoundField DataField="SSlocate_latitude" HeaderText="所在纬度" SortExpression="SSlocate_latitude" />
                <asp:BoundField DataField="SSprice" HeaderText="价格" SortExpression="SSprice" />
                <asp:BoundField DataField="SSrate" HeaderText="折扣" SortExpression="SSrate" />
                <asp:BoundField DataField="SSphone" HeaderText="联系电话" SortExpression="SSphone" />
                <asp:BoundField DataField="SScap" HeaderText="总容量" SortExpression="SScap" />
                <asp:BoundField DataField="SScap_res" HeaderText="剩余容量" SortExpression="SScap_res" />
                <asp:BoundField DataField="SSopen_start_time" HeaderText="开门时间" SortExpression="SSopen_start_time" />
                <asp:BoundField DataField="SSopen_end_time" HeaderText="关门时间" SortExpression="SSopen_end_time" />
                <asp:BoundField DataField="IsInfo" HeaderText="详细介绍" SortExpression="IsInfo" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
            </Fields>
            <PagerStyle Width="500px" />
            <RowStyle Width="500px" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" SelectCommand="SELECT ScenicSpot.SS_id, ScenicSpot.SSname, ScenicSpot.SScity, ScenicSpot.SSlocate_longitude, ScenicSpot.SSlocate_latitude, ScenicSpot.SSprice, ScenicSpot.SSrate, ScenicSpot.SSphone, ScenicSpot.SScap, ScenicSpot.SScap_res, ScenicSpot.SSopen_start_time, ScenicSpot.SSopen_end_time, InfoSpot.IsInfo FROM ScenicSpot INNER JOIN InfoSpot ON ScenicSpot.SS_id = InfoSpot.SS_id WHERE (ScenicSpot.SS_id = @SS_id)" DeleteCommand="DELETE FROM [InfoSpot] WHERE [SS_id] = @SS_id;
DELETE FROM [ScenicSpot] WHERE [SS_id] = @SS_id;" InsertCommand="INSERT INTO ScenicSpot (SS_id, SSname, SScity, SSlocate_longitude, SSlocate_latitude, SSprice, SSrate, SSphone, SScap, SScap_res, SSopen_start_time, SSopen_end_time)
VALUES (@SS_id, @SSname, @SScity, @SSlocate_longitude, @SSlocate_latitude, @SSprice, @SSrate, @SSphone, @SScap, @SScap_res, @SSopen_start_time,  @SSopen_end_time);
INSERT INTO [InfoSpot] ([SS_id], [IsInfo]) VALUES (@SS_id, @IsInfo)" UpdateCommand="UPDATE ScenicSpot
SET
    SSname = @SSname ,
    SScity = @SScity ,
    SSlocate_longitude = @SSlocate_longitude ,
    SSlocate_latitude = @SSlocate_latitude ,
    SSprice = @SSprice ,
    SSrate = @SSrate ,
    SSphone = @SSphone ,
    SScap = @SScap ,
    SScap_res = @SScap_res ,
    SSopen_start_time = @SSopen_start_time ,
    SSopen_end_time = @SSopen_end_time 
WHERE SS_id = @SS_id;
UPDATE [InfoSpot] SET [IsInfo] = @IsInfo WHERE [SS_id] = @SS_id">
            <DeleteParameters>
                <asp:Parameter Name="SS_id" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="SS_id" Type="String" />
                <asp:Parameter Name="SSname" />
                <asp:Parameter Name="SScity" />
                <asp:Parameter Name="SSlocate_longitude" />
                <asp:Parameter Name="SSlocate_latitude" />
                <asp:Parameter Name="SSprice" />
                <asp:Parameter Name="SSrate" />
                <asp:Parameter Name="SSphone" />
                <asp:Parameter Name="SScap" />
                <asp:Parameter Name="SScap_res" />
                <asp:Parameter Name="SSopen_start_time" />
                <asp:Parameter Name="SSopen_end_time" />
                <asp:Parameter Name="IsInfo" Type="String" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="SS_id" PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="SSname" />
                <asp:Parameter Name="SScity" />
                <asp:Parameter Name="SSlocate_longitude" />
                <asp:Parameter Name="SSlocate_latitude" />
                <asp:Parameter Name="SSprice" />
                <asp:Parameter Name="SSrate" />
                <asp:Parameter Name="SSphone" />
                <asp:Parameter Name="SScap" />
                <asp:Parameter Name="SScap_res" />
                <asp:Parameter Name="SSopen_start_time" />
                <asp:Parameter Name="SSopen_end_time" />
                <asp:Parameter Name="SS_id" Type="String" />
                <asp:Parameter Name="IsInfo" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
