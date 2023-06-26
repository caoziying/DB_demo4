<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="path.aspx.cs" Inherits="DB_demo4.path" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width" />
    <title>位置经纬度 + 驾车规划路线</title>
    <script type="text/javascript">
        window._AMapSecurityConfig = {
            securityJsCode: 'd950a5eac14755376f7a6f08f972302a',
        }
    </script>
    <style type="text/css">
        html,
        body,
        #container {
            width: 100%;
            height: 90%;
        }
    </style>
    <style type="text/css">
        #panel {
            position: fixed;
            background-color: white;
            max-height: 90%;
            overflow-y: auto;
            top: 10px;
            right: 10px;
            width: 280px;
        }

            #panel .amap-call {
                background-color: #009cf9;
                border-top-left-radius: 4px;
                border-top-right-radius: 4px;
            }

            #panel .amap-lib-driving {
                border-bottom-left-radius: 4px;
                border-bottom-right-radius: 4px;
                overflow: hidden;
            }
        .btn-primary {}
    </style>
    <link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css" />
    <script src="https://a.amap.com/jsapi_demos/static/demo-center/js/demoutils.js"></script>
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=2.0&key=8875d81135891eb1206cdb0ce947d540&plugin=AMap.Driving"></script>
    <script type="text/javascript" src="https://cache.amap.com/lbs/static/addToolbar.js"></script>
</head>
<body>
    
    <div id="container"></div>
    <div id="panel"></div>
    <p></p>
     <p></p>
   <form id="form1" runat="server"> 
        <div style="text-align: center;">
            <br /><br /><br />
            <asp:Button ID="ret" Text="返回" runat="server" OnClick="rets" CssClass="btn btn-primary" Height="35px" Width="70px" Font-Size="Medium"/>
        </div>
   </form>
    <script type="text/javascript">
        var myposition = new AMap.LngLat(118.71497, 30.90654) ;
        
        var lngLatList = [];
        lngLatList.push(myposition);

        // 通过内联代码获取Session中的数据
<%--        var LatitudeList = <%= (List<string>)(Session["LatitudeList"]) %>;
        var LongitudeList = <%= (List<string>)(Session["LongitudeList"]) %>;--%>
        var LatitudeList = JSON.parse('<%= (Session["LatitudeList"]) %>');
        var LongitudeList = JSON.parse('<%= (Session["LongitudeList"]) %>');

        // 判断 LatitudeList 是否为 null 或 undefined，若为 null 或 undefined，则赋值为空列表
        if (!LatitudeList) {
            LatitudeList = [];
        }

        // 判断 LongitudeList 是否为 null 或 undefined，若为 null 或 undefined，则赋值为空列表
        if (!LongitudeList) {
            LongitudeList = [];
        }

        for (var i = 0; i < LongitudeList.length; i++) {
            var longitude = parseFloat(LongitudeList[i]);
            var latitude = parseFloat(LatitudeList[i]);

            var lngLat = new AMap.LngLat(longitude, latitude);
            lngLatList.push(lngLat);
        }
        // 将二维数组转换为字符串
        var arrayString = JSON.stringify(lngLatList);

        // 在弹窗中显示二维数组内容
        //alert(arrayString);
            
        //});

        //window.navigator.geolocation.getCurrentPosition(function (position) {
        //    myposition = new AMap.LngLat(position.coords.latitude, position.coords.longitude)
        //});

        /*
        AMap.plugin('AMap.Geolocation', function () {
            var geolocation = new AMap.Geolocation({
                // 是否使用高精度定位，默认：true
                enableHighAccuracy: true,
                // 设置定位超时时间，默认：无穷大
                timeout: 100,
            })

            geolocation.getCurrentPosition()
            AMap.event.addListener(geolocation, 'complete', onComplete)
            AMap.event.addListener(geolocation, 'error', onError)

            function onComplete(data) {
                // data是具体的定位信息
                log.success('获取定位成功：' + data)
                position = new AMap.LngLat(data.position.getLng(), data.position.getLat());
            }

            function onError(data) {
                // 定位出错
                log.error('获取定位失败：' + data)
            }
        })*/

        //基本地图加载
        var map = new AMap.Map("container", {
            resizeEnable: true,
            center: [118.73, 31.95],//地图中心点
            zoom: 13 //地图显示的缩放级别
        });
        //构造路线导航类
        var driving = new AMap.Driving({
            map: map,
            pal: "panel"
        });
        
        //lngLatList.push([118.72640, 30.98427]);
        //lngLatList.push([118.73640, 30.96427]);
        //lngLatList.push([117.71497, 31.28427]);

        // 复制数组并去除首部和尾部元素   途经点
        var waypoint = lngLatList.slice(1, -1);
        // 构建opts对象，包含waypoints属性
        var opts = {
            waypoints: waypoint
        };
        // 将二维数组转换为字符串
        var arrayString = JSON.stringify(waypoint);

        // 在弹窗中显示二维数组内容
        //alert(arrayString);
        //var flattenedList = [].concat.apply([], lngLatList);
        // 根据起终点经纬度规划驾车导航路线  ...lngLatList  new AMap.LngLat(118.72640, 30.98427) new AMap.LngLat(117.71497, 31.28427), new AMap.LngLat(118.72640, 30.98427),
        //var qq = [{ keyword: "合肥工业大学宣城校区", city: "宣城" }, { keyword: "宣城中学", city: "宣城" }];
        driving.search(lngLatList[0], lngLatList[lngLatList.length - 1], opts, function(status, result) {
            // result 即是对应的驾车导航信息，相关数据结构文档请参考  https://lbs.amap.com/apiavascript-api/reference/route-search#m_DringResult
            if (status === 'cplete') {
              log.success('绘制驾车路线完成')
            } else{
             onsole.error('获取驾车数据失败：' + result);
            }
        });
        // 使用 apply 方法将二维数组的元素作为参数传递给 driving.search 函数
        //driving.search.apply(null, lngLatList.concat(function (status, result) {
        //    // 处理函数的回调结果
        //    if (status === 'complete') {
        //        log.success('绘制驾车路线完成');
        //    } else {
        //        console.error('获取驾车数据失败：' + result);
        //    }
        //}));

        //    // result 即是对应的驾车导航信息，相关数据结构文档请参考  https://lbs.amap.com/apiavascript-api/reference/route-search#m_DringResult
        //    if (status === 'cplete') {
        //      log.success('绘制驾车路线完成')
        //    } else{
        //     onsole.error('获取驾车数据失败：' + result);
        //    }
        //});
        
    </script>
</body>
</html>
