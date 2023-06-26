<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MerchantManagement.aspx.cs" Inherits="DB_demo4.MerchantManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>商户管理</title>
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
                    <a class="nav-link" href="SpotManagement.aspx" >景点管理</a>
                  </li>
                  <li class="nav-item">
                    <a class="nav-link  active" href="#" >商户管理</a>
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
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Mc_id" DataSourceID="SqlDataSource1" CssClass="table table-bordered table-striped" >
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="Mc_id" HeaderText="商户编号" ReadOnly="True" SortExpression="Mc_id" />
                    <asp:BoundField DataField="Mcname" HeaderText="商户名称" SortExpression="Mcname" />
                    <asp:BoundField DataField="Mctype" HeaderText="商户类型" SortExpression="Mctype" />
                    <asp:BoundField DataField="Mcphone" HeaderText="联系电话" SortExpression="Mcphone" />
                    <asp:BoundField DataField="Mclocate_longitude" HeaderText="所在经度" SortExpression="Mclocate_longitude" />
                    <asp:BoundField DataField="Mclocate_latitude" HeaderText="所在纬度" SortExpression="Mclocate_latitude" />
                    <asp:BoundField DataField="Mopen_start_time" HeaderText="开门时间" SortExpression="Mopen_start_time" />
                    <asp:BoundField DataField="Mopen_end_time" HeaderText="关门时间" SortExpression="Mopen_end_time" />
                </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" SelectCommand="SELECT * FROM [Merchant]"></asp:SqlDataSource>
        </div>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="Mc_id" DataSourceID="SqlDataSource2"  Height="50px" Width="1420px" FieldHeaderStyle-Width="100" OnItemDeleted="DetailsView1_ItemDeleted" OnItemInserted="DetailsView1_ItemInserted">
            <FieldHeaderStyle Width="100px" />
            <Fields>
                <asp:BoundField DataField="Mc_id" HeaderText="商户编号" ReadOnly="True" SortExpression="Mc_id" />
                <asp:BoundField DataField="Mcname" HeaderText="商户名称" SortExpression="Mcname" />
                <asp:BoundField DataField="Mctype" HeaderText="商户类型" SortExpression="Mctype" />
                <asp:BoundField DataField="Mcphone" HeaderText="联系电话" SortExpression="Mcphone" />
                <asp:BoundField DataField="Mclocate_longitude" HeaderText="所在经度" SortExpression="Mclocate_longitude" />
                <asp:BoundField DataField="Mclocate_latitude" HeaderText="所在纬度" SortExpression="Mclocate_latitude" />
                <asp:BoundField DataField="Mopen_start_time" HeaderText="开门时间" SortExpression="Mopen_start_time" />
                <asp:BoundField DataField="Mopen_end_time" HeaderText="关门时间" SortExpression="Mopen_end_time" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConflictDetection="CompareAllValues" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" DeleteCommand="DELETE FROM [Merchant] WHERE [Mc_id] = @original_Mc_id AND [Mcname] = @original_Mcname AND [Mctype] = @original_Mctype AND (([Mcphone] = @original_Mcphone) OR ([Mcphone] IS NULL AND @original_Mcphone IS NULL)) AND [Mclocate_longitude] = @original_Mclocate_longitude AND [Mclocate_latitude] = @original_Mclocate_latitude AND (([Mopen_start_time] = @original_Mopen_start_time) OR ([Mopen_start_time] IS NULL AND @original_Mopen_start_time IS NULL)) AND (([Mopen_end_time] = @original_Mopen_end_time) OR ([Mopen_end_time] IS NULL AND @original_Mopen_end_time IS NULL))" InsertCommand="INSERT INTO [Merchant] ([Mc_id], [Mcname], [Mctype], [Mcphone], [Mclocate_longitude], [Mclocate_latitude], [Mopen_start_time], [Mopen_end_time]) VALUES (@Mc_id, @Mcname, @Mctype, @Mcphone, @Mclocate_longitude, @Mclocate_latitude, @Mopen_start_time, @Mopen_end_time)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT * FROM [Merchant] WHERE ([Mc_id] = @Mc_id)" UpdateCommand="UPDATE [Merchant] SET [Mcname] = @Mcname, [Mctype] = @Mctype, [Mcphone] = @Mcphone, [Mclocate_longitude] = @Mclocate_longitude, [Mclocate_latitude] = @Mclocate_latitude, [Mopen_start_time] = @Mopen_start_time, [Mopen_end_time] = @Mopen_end_time WHERE [Mc_id] = @original_Mc_id AND [Mcname] = @original_Mcname AND [Mctype] = @original_Mctype AND (([Mcphone] = @original_Mcphone) OR ([Mcphone] IS NULL AND @original_Mcphone IS NULL)) AND [Mclocate_longitude] = @original_Mclocate_longitude AND [Mclocate_latitude] = @original_Mclocate_latitude AND (([Mopen_start_time] = @original_Mopen_start_time) OR ([Mopen_start_time] IS NULL AND @original_Mopen_start_time IS NULL)) AND (([Mopen_end_time] = @original_Mopen_end_time) OR ([Mopen_end_time] IS NULL AND @original_Mopen_end_time IS NULL))">
            <DeleteParameters>
                <asp:Parameter Name="original_Mc_id" Type="String" />
                <asp:Parameter Name="original_Mcname" Type="String" />
                <asp:Parameter Name="original_Mctype" Type="String" />
                <asp:Parameter Name="original_Mcphone" Type="String" />
                <asp:Parameter Name="original_Mclocate_longitude" Type="Decimal" />
                <asp:Parameter Name="original_Mclocate_latitude" Type="Decimal" />
                <asp:Parameter DbType="Time" Name="original_Mopen_start_time" />
                <asp:Parameter DbType="Time" Name="original_Mopen_end_time" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="Mc_id" Type="String" />
                <asp:Parameter Name="Mcname" Type="String" />
                <asp:Parameter Name="Mctype" Type="String" />
                <asp:Parameter Name="Mcphone" Type="String" />
                <asp:Parameter Name="Mclocate_longitude" Type="Decimal" />
                <asp:Parameter Name="Mclocate_latitude" Type="Decimal" />
                <asp:Parameter DbType="Time" Name="Mopen_start_time" />
                <asp:Parameter DbType="Time" Name="Mopen_end_time" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" Name="Mc_id" PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="Mcname" Type="String" />
                <asp:Parameter Name="Mctype" Type="String" />
                <asp:Parameter Name="Mcphone" Type="String" />
                <asp:Parameter Name="Mclocate_longitude" Type="Decimal" />
                <asp:Parameter Name="Mclocate_latitude" Type="Decimal" />
                <asp:Parameter DbType="Time" Name="Mopen_start_time" />
                <asp:Parameter DbType="Time" Name="Mopen_end_time" />
                <asp:Parameter Name="original_Mc_id" Type="String" />
                <asp:Parameter Name="original_Mcname" Type="String" />
                <asp:Parameter Name="original_Mctype" Type="String" />
                <asp:Parameter Name="original_Mcphone" Type="String" />
                <asp:Parameter Name="original_Mclocate_longitude" Type="Decimal" />
                <asp:Parameter Name="original_Mclocate_latitude" Type="Decimal" />
                <asp:Parameter DbType="Time" Name="original_Mopen_start_time" />
                <asp:Parameter DbType="Time" Name="original_Mopen_end_time" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
