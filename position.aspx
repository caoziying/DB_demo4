<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="position.aspx.cs" Inherits="DB_demo4.position" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width"/>
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
            height: 100%;
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
    </style>
    <link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css" />
    <script src="https://a.amap.com/jsapi_demos/static/demo-center/js/demoutils.js"></script>
    <script type="text/javascript" src="https://webapi.amap.com/maps?v=2.0&key=8875d81135891eb1206cdb0ce947d540&plugin=AMap.Driving"></script>
    <script type="text/javascript" src="https://cache.amap.com/lbs/static/addToolbar.js"></script>
</head>
<body>
    <div id="container"></div>
    <div id="panel"></div>
    <script type="text/javascript">
        var position_start = new AMap.LngLat(118.71497, 30.90654);

        var longitude =  <%= Session["pre_lng"].ToString() %>;
        var latitude = <%= Session["pre_lat"].ToString()%>;
        var position_end = new AMap.LngLat(longitude, latitude);

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
            panel: "panel"
        });
        //new AMap.LngLat(118.72640, 30.98427)
        // 根据起终点经纬度规划驾车导航路线
        driving.search(position_start, position_end, function (status, result) {
            // result 即是对应的驾车导航信息，相关数据结构文档请参考  https://lbs.amap.com/api/javascript-api/reference/route-search#m_DrivingResult
            if (status === 'complete') {
                log.success('绘制驾车路线完成')
            } else {
                log.error('获取驾车数据失败：' + result)
            }
        });

    </script>
</body>
</html>
