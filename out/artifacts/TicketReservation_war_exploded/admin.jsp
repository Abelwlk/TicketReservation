<%--
  Created by IntelliJ IDEA.
  User: 
  Date: 2019/10/9
  Time: 17:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>主界面</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="laydate/laydate.js"></script> <!-- 改成你的路径 -->
    <link rel="stylesheet" href="css/bootstrap-select.min.css">
    <script src="js/bootstrap-select.min.js"></script>
    <script src="js/i18n/defaults-zh_CN.min.js"></script>
    <style type="text/css" >
        .table th, .table td {
            text-align: center;
            vertical-align: middle!important;
        }
        .layui-laydate-content>.layui-laydate-list {
            padding-bottom: 0px;
            overflow: hidden;
        }
        .layui-laydate-content>.layui-laydate-list>li{
            width:50%
        }

        .merge-box .scrollbox .merge-list {
            padding-bottom: 5px;
        }
    </style>

    <script type="text/javascript">
        function load(currentPage) {
            $.post("city/pageQuery",{"cCurrentPage":currentPage},function (data){//
                var trs="";
                var list=data.list;
                $("#cCurrentPage").text(data.currentPage);
                $("#cToalPage").text(data.totalPage);
                for(var i=0;i<list.length;i++) {
                    var tr='<tr><td>'+list[i].cid+'</td><td>'+list[i].cityName+'</td><td><button type="button" class="btn btn-success" value="'+list[i].cid+'" data-toggle="modal" data-target="#editmodal" onclick="cEdit()">修改</button><button type="button" class="btn btn-danger col-md-offset-1" value="'+list[i].cid+'" data-toggle="modal" data-target="#delmodal" onclick="cDel(this)">删除</button></td></tr>';
                    trs+=tr;
                }
                $("#cbody").html(trs);
            });
        }

        //加载
        $(function () {
            load();
            $("#cityManager").click(function () {
                load();
            });
        });

        //修改
        function cEdit(){
            $("#cbody tr").click(function() {
                var cid=$(this).children("td").eq(0).text();
                var cname=$(this).children("td").eq(1).text()
                $("#editCid").text(cid);
                $("#editCname").val(cname);
            });
        }

        //删除
        function cDel(b){
            $("#delCid").val($(b).val());
        }
        //上一页
        $(function () {
            $("#cPrevious").click(function () {
                var pre=Number($("#cCurrentPage").text());
                if(pre > 1)
                {
                    load(pre-1);
                }
            });
        });

        //下一页
        $(function () {
            $("#cNext").click(function () {
                var next=Number($("#cCurrentPage").text());
                if(next < Number($("#cToalPage").text())){
                    load(next+1);
                }
            });
        });
    </script>
    <script type="text/javascript">
        //查询城市--下拉框
        function loadCity(){
            $.get("city/findAll",{},function (data) {//[{cid:xx,cityName:xx},{cid:xx,cityName:xx}]
                var lis="";
                for(var i=0;i<data.length;i++){
                    var li='<option value="'+data[i].cid+'">'+data[i].cityName+'</option>';
                    lis+=li;
                }
                $(".selectpicker").html(lis);
                $('.selectpicker').selectpicker('refresh');
            });
        }
        $(function () {
            loadCity();
        });
        //加载班次数据
        function loadShift(currentPage){
            if($("#tStartCid").val()==""||$("#tArriveCid").val()=="")
            {
                alert("请选择城市");
            }else if($("#tStartCid").val()==$("#tArriveCid").val()){
                alert("开始和到达城市不能相同！");
            }else {
                $.post("ticket/pageQuery",{"tStartCid":$("#tStartCid").val(),"tArriveCid":$("#tArriveCid").val(),"tDate":$("#tDate").val(),"ticketCurrentPage":currentPage},function (data){//
                    var trs="";
                    var list=data.list;
                    $("#tCurrentPage").text(data.currentPage);
                    $("#tToalPage").text(data.totalPage);
                    for(var i=0;i<list.length;i++) {
                        var tr='<tr><td>'+list[i].time+'</td> <td>'+list[i].price+'</td> <td>'+list[i].num+'</td> <td> <button type="button" class="btn btn-success" value="'+list[i].tid+'" onclick="ticketEdit(this)" data-toggle="modal" data-target="#ticketEditmodal">修改</button><button type="button" class="btn btn-danger col-md-offset-1" value="'+list[i].tid+'" onclick="ticketDel(this)" data-toggle="modal" data-target="#ticketDelmodal">删除</button></td></tr>';
                        trs+=tr;
                    }
                    $("#tbody").html(trs);
                });
            }
        }

        //查询班次---表单
        $(function () {
            $("#ticketSearch").submit(function () {
                loadShift();
                return false;
            });
        });

        //修改
        function ticketEdit(b){
            $("#editTid").val($(b).val());
            $.post("ticket/findById",{"tid":$(b).val()},function (data) {
                var arr=data.time.split(":");
                var time=arr[0]+":"+arr[1];
                $("#editTime").val(time);
                $("#editPrice").val(data.price);
                $("#editNum").val(data.num);
            });
        }
        //修改
        function ticketDel(b){
            $("#delTid").val($(b).val());
        }

        //上一页
        $(function () {
            $("#tPrevious").click(function () {
                var pre=Number($("#tCurrentPage").text());
                if(pre > 1)
                {
                    loadShift(pre-1);
                }
            });
        });

        //下一页
        $(function () {
            $("#tNext").click(function () {
                var next=Number($("#tCurrentPage").text());
                if(next < Number($("#tToalPage").text())){
                    loadShift(next+1);
                }
            });
        });
    </script>

</head>
<body style="background: #353f42;height: 730px;">
    <div class="container" style="height: 100%">
        <div class="hidden">
            <input id="u01" value="${user.username}">
            <input id="u02" value="${user.password}">
            <input id="u03" value="${user.truthName}">
            <input id="u04" value="${user.telephone}">
            <input id="u05" value="${user.identity}">
        </div>
        <div class="row" style="height: 15%;">
            <h1 style="color: #e7e7e7">欢迎，${user.username}<div id="uid" hidden>${user.uid}</div></h1>
        </div>
        <div class="row" style="height: 85%;border: solid grey 2px;">
            <div class="col-md-3" style="height:100%;background-color: #e7e7e7;border-right: solid gray 1px;">
                <ul class="nav nav-pills nav-stacked" id="myTab" style="margin-top: 20px;text-align: center;">
                    <li id="cityManager" class="active"><a href="#city_manager">城市管理</a></li>
                    <li id="shiftManager"><a href="#ticket_manager">班次管理</a></li>
                    <li><button type="button" class="btn btn-danger" style="margin-top: 360px;" data-toggle="modal" data-target="#exitmodal">退出登录</button></li>
                </ul>
            </div>
            <div class="col-md-9" style="height:100%;background-color: #e7e7e7;">
                <div class="tab-content">
                    <div class="tab-pane active" id="city_manager">
                        <div class="row" style="height: 60px;margin-top: 25px;">
                            <button type="button" class="btn btn-primary col-md-1 col-sm-offset-1" data-toggle="modal" data-target="#addmodal">增加</button>
                        </div>
                        <div class="row" style="height: 400px;">
                            <table class="table table-hover table-condensed table-bordered">
                                <thead>
                                <tr>
                                    <th>城市编号</th>
                                    <th>城市名称</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="cbody">
                                    <%--<tr><td>111</td><td>江苏</td><td><button type="button" class="btn btn-success">修改</button><button type="button" class="btn btn-danger col-md-offset-1">删除</button></td></tr>--%>
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <nav aria-label="Page navigation" style="width: 90%;margin-left:5%;">
                                <ul class="pager">
                                    <li class="previous" id="cPrevious"><a href="#"><span aria-hidden="true">上一页</span></a></li>
                                    <li><span>第<span id="cCurrentPage">0</span>页</span></li>
                                    <li><span>共<span id="cToalPage">0</span>页</span></li>
                                    <li class="next" id="cNext"><a href="#"><span aria-hidden="true">下一页</span></a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <div class="tab-pane fade" id="ticket_manager">
                        <div class="row" style="height: 60px;margin-top: 25px;">
                            <form class="form-inline" id="ticketSearch">
                                <div class="col-md-1 btn-group">
                                    <select class="selectpicker col-sm-1" title="开始城市" data-style="btn-primary" id="tStartCid">
                                    </select>
                                </div>
                                <div class="col-md-2 col-md-offset-1">
                                    <select class="selectpicker col-sm-1" title="到达城市" data-style="btn-primary" id="tArriveCid">
                                    </select>
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control" placeholder="请选择日期" id="tDate">
                                    <script>
                                        laydate.render({
                                            elem: '#tDate'
                                            ,value: new Date()
                                            ,isInitValue: false //是否允许填充初始值，默认为 true
                                            ,min:0
                                            ,max:7
                                            ,showBottom: false
                                            ,theme:'#337AB7'
                                            ,done: function(value, date){
                                                loadShift();
                                            }
                                        });
                                    </script>
                                </div>
                                <button type="submit" class="btn btn-primary">查询</button>
                                <button type="button" class="btn btn-primary col-md-offset-2" data-toggle="modal" data-target="#ticketAddmodal">添加班次</button>
                            </form>
                        </div>
                        <div class="row" style="height: 400px;">
                            <table class="table table-hover table-condensed table-bordered">
                                <thead>
                                <tr>
                                    <th>发车时间</th>
                                    <th>票价</th>
                                    <th>余票</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="tbody">
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <nav aria-label="Page navigation" style="width: 90%;margin-left:5%;">
                                <ul class="pager">
                                    <li class="previous" id="tPrevious"><a href="#"><span aria-hidden="true">上一页</span></a></li>
                                    <li><span>第<span id="tCurrentPage">0</span>页</span></li>
                                    <li><span>共<span id="tToalPage">0</span>页</span></li>
                                    <li class="next" id="tNext"><a href="#"><span aria-hidden="true">下一页</span></a></li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            //退出
            <div class="modal fade" id="exitmodal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">确认退出？</h4>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" id="confirmExit">确认</button>
                            <script type="text/javascript">
                                $(function () {
                                    $('#confirmExit').click(function () {
                                        location.href="${pageContext.request.contextPath}/user/exit";
                                    });
                                });
                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            //增加城市对话框
            <div class="modal fade" id="addmodal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">添加城市</h4>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="form-group">
                                    <label>城市名称</label>
                                    <input type="text" class="form-control" id="cityName">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="confirmAdd">确认</button>
                            <script type="text/javascript">
                                $(function () {
                                    $('#confirmAdd').click(function () {
                                        $.post("city/add",{"cityName":$("#cityName").val()},function (data) {
                                            if(data.flag==false){
                                                alert(data.errorMsg);
                                            }else{
                                                alert("添加成功！");
                                            }
                                            load($("#cCurrentPage").text());
                                            loadCity();
                                        });
                                    });
                                });
                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            //修改城市对话框
            <div class="modal fade" id="editmodal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">修改</h4>
                        </div>
                        <div class="modal-body">
                            <form>
                                <div class="form-group">
                                    <label>城市编号</label>
                                    <span class="input-group uneditable-input" id="editCid"></span>
                                </div>
                                <div class="form-group">
                                    <label>城市名称</label>
                                    <input type="text" class="form-control" id="editCname">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="confirmEdit">确认</button>
                            <script type="text/javascript">
                                $(function () {
                                    $('#editmodal').modal('hide');
                                    $('#confirmEdit').click(function () {
                                        $.post("city/edit",{"cid":$("#editCid").text(),"cname":$("#editCname").val()},function (data) {
                                            if(data.flag==false){
                                                alert(data.errorMsg);
                                            }else{
                                                alert("修改成功！");
                                            }
                                            load($("#cCurrentPage").text());
                                            loadCity();
                                        });
                                    });
                                });
                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            //删除城市对话框
            <div class="modal fade" id="delmodal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">确认删除？</h4>
                        </div>
                        <div class="modal-footer">
                            <input id="delCid" type="hidden">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="confirmDel">确认</button>
                            <script type="text/javascript">
                                $(function () {
                                    $('#confirmDel').click(function () {
                                        $.post("city/delete",{"cid":$("#delCid").val()},function (data) {
                                            if(data.flag==false){
                                                alert(data.errorMsg);
                                            }else{
                                                alert("删除成功！");
                                            }
                                            load($("#tCurrentPage").text());
                                            loadCity();
                                        });
                                    });
                                });
                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
        </div>
        <div class="row">
            //增加班次对话框
            <div class="modal fade" id="ticketAddmodal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">添加班次</h4>
                        </div>
                        <div class="modal-body">
                            <form id="addTicketForm">
                                <div class="form-group form-inline">
                                    <select class="selectpicker col-md-6" title="开始城市" data-style="btn-primary" id="addStartCid" name="startCid"></select>
                                    <select class="selectpicker col-md-6" title="到达城市" data-style="btn-primary" id="addArriveCid" name="arriveCid"></select>
                                </div>
                                <div class="form-group">
                                    <label>班次日期</label>
                                    <input type="text" class="form-control" placeholder="请选择日期" id="addDate" name="date">
                                    <script>
                                        laydate.render({
                                            elem: '#addDate'
                                            ,value: new Date()
                                            ,isInitValue: false //是否允许填充初始值，默认为 true
                                            ,min:0
                                            ,max:7
                                            ,showBottom: false
                                            ,theme:'#337AB7'
                                        });
                                    </script>
                                </div>
                                <div class="form-group">
                                    <label>发车时间</label>
                                    <input type="text" class="form-control" placeholder="请选择日期" id="addTime" name="time">
                                    <script>
                                        laydate.render({
                                            elem: '#addTime'
                                            ,type:'time'
                                            ,format:'HH:mm'
                                            ,value:'00:00'
                                            ,theme:'#337AB7'
                                        });
                                    </script>
                                </div>
                                <div class="form-group form-inline">
                                    <label>票价</label>
                                    <input type="text" class="form-control" style="width: 50px;" name="price" id="price">
                                    <label class="col-md-offset-1">总数</label>
                                    <input type="text" class="form-control" style="width: 50px;" name="num" id="num">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" id="tConfirmAdd">确认添加</button>
                            <script type="text/javascript">
                                $(function () {
                                    $('#tConfirmAdd').click(function () {
                                        if($("#addStartCid").val()==""||$("#addArriveCid").val()==""||$("#price").val()==""||$("#num").val()=="")
                                        {
                                            alert("请将信息填写完整！");
                                        }else if($("#addStartCid").val()==$("#addArriveCid").val()) {
                                            alert("开始和到达城市不能相同！");
                                        }else {
                                            $.post("ticket/add",$("#addTicketForm").serialize(),function (data) {
                                                if(data.flag==false){
                                                    alert(data.errorMsg);
                                                }else{
                                                    alert("添加成功！");
                                                    $('#ticketAddmodal').modal('hide');
                                                }
                                            });
                                        }
                                    });
                                });
                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            //修改班次对话框
            <div class="modal fade" id="ticketEditmodal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">修改班次</h4>
                        </div>
                        <div class="modal-body">
                            <form id="editTicketForm">
                                <div class="form-group">
                                    <input type="hidden" id="editTid" name="tid">
                                    <label>发车时间</label>
                                    <input type="text" class="form-control" placeholder="请选择日期" id="editTime" name="time">
                                    <script>
                                        laydate.render({
                                            elem: '#editTime'
                                            ,type:'time'
                                            ,format:'HH:mm'
                                            ,theme:'#337AB7'
                                        });
                                    </script>
                                </div>
                                <div class="form-group form-inline">
                                    <label>票价</label>
                                    <input type="text" class="form-control" style="width: 50px;" name="price" id="editPrice">
                                    <label class="col-md-offset-1">总数</label>
                                    <input type="text" class="form-control" style="width: 50px;" name="num" id="editNum">
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" id="tConfirmEdit">确认修改</button>
                            <script type="text/javascript">
                                $(function () {
                                    $('#tConfirmEdit').click(function () {
                                        $.post("ticket/edit",$("#editTicketForm").serialize(),function (data) {
                                            if(data.flag==false){
                                                alert(data.errorMsg);
                                            }else{
                                                alert("添加成功！");
                                                $('#ticketEditmodal').modal('hide');
                                            }
                                        });
                                        loadShift($("#tCurrentPage").text());
                                    });
                                });
                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
            //删除班次对话框
            <div class="modal fade" id="ticketDelmodal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-sm" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title">确认删除？</h4>
                        </div>
                        <div class="modal-footer">
                            <input id="delTid" type="hidden">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" id="ticketconfirmDel">确认</button>
                            <script type="text/javascript">
                                $(function () {
                                    $('#ticketconfirmDel').click(function () {
                                        $.post("ticket/delete",{"tid":$("#delTid").val()},function (data) {
                                            if(data.flag==false){
                                                alert(data.errorMsg);
                                            }else{
                                                alert("删除成功！");
                                                $('#ticketDelmodal').modal('hide');
                                            }
                                            loadShift($("#tCurrentPage").text());
                                        });
                                    });
                                });
                            </script>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div><!-- /.modal -->
        </div>
    </div>
</div>
<script>
    $(function () {
        $('#myTab a:first').tab('show');
    })
    $('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    })
</script>
</body>
</html>
