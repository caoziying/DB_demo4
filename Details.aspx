<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Details.aspx.cs" Inherits="DB_demo4.Details" EnableEventValidation="false" %>

<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>景点详情</title>
    <!-- 引入 Bootstrap 样式表 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <asp:Image ID="imgSpot" runat="server" CssClass="img-fluid" ImageUrl="img/test.jpg" Width="600" Height="400" />
                </div>
                <div class="col-md-6">
                    <!-- 其他信息内容 -->
                    <asp:Label ID="lblSpotName" runat="server" Text="" Font-Size="30px" Font-Bold="true" ForeColor="#ff9933"></asp:Label>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnRet" runat="server" Text="返回前页" CssClass="btn btn-primary btn-sm" OnClick="retPre"/>
                    <p></p>
                    <p>
                        <asp:Label ID="Label1" runat="server" Text="所在城市：" Font-Size="15px" Font-Bold="true"></asp:Label>
                        <asp:Label ID="lblCity" runat="server" Text="" Font-Size="15px"></asp:Label>
                    </p>
                    <p>
                        <asp:Label ID="Label2" runat="server" Text="门票价格：" Font-Size="15px" Font-Bold="true"></asp:Label>
                        <asp:Label ID="lblPrice" runat="server" Text="" Font-Size="15px"></asp:Label>
                    </p>
                    <p>
                        <asp:Label ID="Label3" runat="server" Text="开放时间：" Font-Size="15px" Font-Bold="true"></asp:Label>
                        <asp:Label ID="lblOpentime" runat="server" Text="" Font-Size="15px"></asp:Label>
                    </p>
                    <p>
                        <asp:Label ID="Label4" runat="server" Text="联系电话：" Font-Size="15px" Font-Bold="true"></asp:Label>
                        <asp:Label ID="lblPhone" runat="server" Text="" Font-Size="15px"></asp:Label>
                    </p>
                    <p><asp:Label ID="lblInfo" runat="server" Text="" Font-Size="15px" ForeColor="#3399ff" Font-Bold="true"></asp:Label></p>


                    


                    <p>&nbsp;</p>
                </div>

            </div>

            <div class="row mt-4">
                <div class="col-md-12">
                    <p>
                        <asp:Label ID="Label8" runat="server" Text="游玩信息统计：" Font-Size="20px" Font-Bold="true"></asp:Label></p>
                    <p>

                        <asp:Chart ID="Chart1" runat="server" DataSourceID="SqlDataSource3" Width="420px" BackColor="204, 255, 153" BorderlineColor="Black">
                            <Series>
                                <asp:Series Name="Series1" XValueMember="Smonth" YValueMembers="Snum">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX Title="月份"></AxisX>
                                    <AxisY Title="客流量"></AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                         <asp:Chart ID="Chart2" runat="server" DataSourceID="SqlDataSource3" Width="420px" BackColor="204, 255, 153" BorderlineColor="Black">
                            <Series>
                                <asp:Series Name="Series1" XValueMember="Smonth" YValueMembers="Snum" ChartType="Line">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX Title="月份"></AxisX>
                                    <AxisY Title="客流量"></AxisY>
                                </asp:ChartArea>
                            </ChartAreas>

                        </asp:Chart>
                        <asp:Chart ID="Chart3" runat="server" DataSourceID="SqlDataSource6" BackColor="204, 255, 153" BorderlineColor="Black" Width="420px">
                            <Series>
                                <asp:Series Name="Series1" XValueMember="Syear" YValueMembers="total_visitors"></asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartArea1">
                                    <AxisX Title="年份"></AxisX>
                                    <AxisY Title="客流量"></AxisY>
                                </asp:ChartArea>
                            </ChartAreas>
                        </asp:Chart>
                        <asp:SqlDataSource ID="SqlDataSource6" runat="server" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" SelectCommand="SELECT * FROM [view_total_visitors] WHERE ([SS_id] = @SS_id) ORDER BY [Syear]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="spot" Name="SS_id" PropertyName="SelectedValue" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource7" runat="server"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" SelectCommand="SELECT * FROM [Statistic] WHERE (([SS_id] = @SS_id) AND ([Syear] = @Syear)) ORDER BY [Smonth]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="spot" Name="SS_id" PropertyName="SelectedValue" Type="String" />
                                <asp:ControlParameter ControlID="year" Name="Syear" PropertyName="SelectedValue" Type="Decimal" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <br />
                        <asp:DropDownList ID="spot" runat="server" DataSourceID="SqlDataSource1" DataTextField="SSname" DataValueField="SS_id" OnSelectedIndexChanged="spot_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" SelectCommand="SELECT [SS_id], [SSname] FROM [ScenicSpot]"></asp:SqlDataSource>
                        <asp:DropDownList ID="year" runat="server" DataSourceID="SqlDataSource2" DataTextField="Syear" DataValueField="Syear" OnSelectedIndexChanged="year_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>

                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:mydbConnectionString %>" SelectCommand="SELECT DISTINCT Syear FROM Statistic WHERE (SS_id = @SS_id)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="spot" Name="SS_id" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </p>
                    <p>
                        <asp:Label ID="Label5" runat="server" Text="周边商户：" Font-Size="20px" Font-Bold="true"></asp:Label>
                        <asp:Label ID="lblMerchant" runat="server" Text="" Font-Size="15px"></asp:Label>
                    </p>
                    <%-- 周边商户列表 --%>
                    <asp:GridView ID="merchants" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="False" DataKeyNames="Mc_id">
                        <Columns>
                            <asp:TemplateField HeaderText="序号">
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="Mc_id" HeaderText="商户编号"/>--%>
                            <asp:BoundField DataField="Mcname" HeaderText="商户名称"/>
                            <asp:BoundField DataField="Mctype" HeaderText="商户类型" />
                            <asp:BoundField DataField="Mcphone" HeaderText="联系电话" />
                            <asp:BoundField DataField="Mopen_start_time" HeaderText="开放时间" />
                            <asp:BoundField DataField="Mopen_end_time" HeaderText="关闭时间" />
                            <asp:BoundField DataField="Mdistance" HeaderText="与景点间距离" />
                            <asp:TemplateField HeaderText="添加到行程" HeaderStyle-Width="100px" ItemStyle-HorizontalAlign="Center">
                                <ItemTemplate>
                                    <asp:Button ID="btnAddToItinerary" runat="server" Text="Add" CssClass="btn btn-sm btn-secondary" OnClick="btnAddToItinerary_Click" CommandArgument='<%# Eval("Mc_id") %>'/>
                                </ItemTemplate>
                            </asp:TemplateField>


                        </Columns>
                    </asp:GridView>
                </div>
                <div>
                    <p>
                        <asp:Label ID="Label6" runat="server" Text="周围交通：" Font-Size="20px" Font-Bold="true"></asp:Label>
                    </p>
                    <iframe frameborder="0" style="width: 100%; height: 600px" src="transportation.aspx"></iframe>
                </div>
                <div>
                    <p>
                        <asp:Label ID="Label7" runat="server" Text="驾车路线：" Font-Size="20px" Font-Bold="true"></asp:Label>
                    </p>
                    <iframe frameborder="0" style="width: 100%; height: 600px" src="position.aspx"></iframe>
                </div>
            </div>

        </div>
    <!-- 引入 Bootstrap 脚本 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    </form>
    </body>
</html>