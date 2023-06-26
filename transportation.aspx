<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="transportation.aspx.cs" Inherits="DB_demo4.transportation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width" />
    <title>公交站点查询</title>
        <script type="text/javascript">
            window._AMapSecurityConfig = {
                securityJsCode: 'd950a5eac14755376f7a6f08f972302a',
            }
        </script>
        <link rel="stylesheet" href="https://a.amap.com/jsapi_demos/static/demo-center/css/demo-center.css"/> 
    <style type="text/css">
       html,body,#container{
           height:100%;
       }
    </style>
</head>
<body>
<div id="container"></div>
<div id="tip" class='info' style='min-width:18rem;'></div>

<div class="input-card" style='width:18rem;'>
    <label style='color:grey'>公交站点查询</label>
    <div class="input-item">
            <div class="input-item-prepend"><span class="input-item-text" >站名</span></div>
        <form id="form1" runar="server">
            <asp:Label ID="stationKeyWord" runat="server" Text="合肥工业大学宣城校区"></asp:Label>
        </form>
            
    </div>
    <input id="search" type="button" class="btn" value="查询" />
</div>


<script type="text/javascript" src="https://webapi.amap.com/maps?v=2.0&key=8875d81135891eb1206cdb0ce947d540&plugin=AMap.StationSearch"></script>
<script type="text/javascript">
    var map = new AMap.Map("container", {
        resizeEnable: true,
        center: [118.73, 31.95],//地图中心点
        zoom: 13 //地图显示的缩放级别
    });
    var markers = [];
    stationSearch();
    /*公交站点查询*/
    function stationSearch() {
        // 移除原有marker
        map.remove(markers);
        markers = [];
        var stationKeyWord = document.getElementById('stationKeyWord').textContent;
        if (!stationKeyWord) return
        //实例化公交站点查询类
        var station = new AMap.StationSearch({
            pageIndex: 1, //页码
            pageSize: 5, //单页显示结果条数
            city: '0563'   //确定搜索城市
        });
        station.search(stationKeyWord, function (status, result) {
            if (status === 'complete' && result.info === 'OK') {
                stationSearch_CallBack(result);
            } else {
                document.getElementById('tip').innerHTML = JSON.stringify(result);
            }
        });
    }
    /*公交站点查询返回数据解析*/
    function stationSearch_CallBack(searchResult) {
        var stationArr = searchResult.stationInfo;
        var searchNum = stationArr.length;
        if (searchNum > 0) {
            document.getElementById('tip').innerHTML = '查询结果：共' + searchNum + '个相关站点';
            for (var i = 0; i < searchNum; i++) {
                var marker = new AMap.Marker({
                    icon: new AMap.Icon({
                        image: '//a.amap.com/jsapi_demos/static/resource/img/pin.png',
                        size: new AMap.Size(32, 32),
                        imageSize: new AMap.Size(32, 32)
                    }),
                    offset: new AMap.Pixel(-16, -32),
                    position: stationArr[i].location,
                    map: map,
                    title: stationArr[i].name
                });
                marker.info = new AMap.InfoWindow({
                    content: stationArr[i].name,
                    offset: new AMap.Pixel(0, -30)
                });
                marker.on('mouseover', function (e) {
                    e.target.info.open(map, e.target.getPosition())
                })
                markers.push(marker);
            }
            map.setFitView();
        }
    }
    document.getElementById('search').onclick = stationSearch;
</script>
</body>
</html>