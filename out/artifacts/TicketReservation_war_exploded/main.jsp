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
    </style>
    <script type="text/javascript">
        //查询城市--下拉框
        $(function () {
            $.get("city/findAll",{},function (data) {//[{cid:xx,cityName:xx},{cid:xx,cityName:xx}]
                var lis="";
                for(var i=0;i<data.length;i++){
                    var li='<option value="'+data[i].cid+'">'+data[i].cityName+'</option>';
                    lis+=li;
                }
                $(".selectpicker").html(lis);
                $('.selectpicker').selectpicker('refresh');
            });
        });

        //预定功能--按钮
        function reservation(button){
            //alert($(button).val()+"======"+$("#uid").text());
            $.post("ticket/reservation",{"tid":$(button).val(),"uid":$("#uid").text()},function (data) {
                if(data.flag==false){
                    alert(data.errorMsg);
                }else{
                    alert("预定成功！");
                }
                load($("#tCurrentPage").text());
            });
        }

        //加载班次数据
        function load(currentPage){
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
                        var tr='<tr><td>'+list[i].time+'</td> <td>'+list[i].price+'</td> <td>'+list[i].num+'</td> <td> <button type="button" class="btn btn-primary" value="'+list[i].tid+'" onclick="reservation(this)">预订</button></td></tr>';
                        trs+=tr;
                    }
                    $("#tbody").html(trs);
                });
            }
        }

        //查询班次---表单
        $(function () {
           $("#ticketSearch").submit(function () {
                load();
               return false;
           });
        });

        //上一页
        $(function () {
           $("#tPrevious").click(function () {
               var pre=Number($("#tCurrentPage").text());
               if(pre > 1)
               {
                   load(pre-1);
               }
           });
        });

        //下一页
        $(function () {
            $("#tNext").click(function () {
                var next=Number($("#tCurrentPage").text());
                if(next < Number($("#tToalPage").text())){
                    load(next+1);
                }
            });
        });

    </script>
    <script type="text/javascript">

        function cancelOrder(button){
            $.post("order/cancelOrder",{"orderId":$(button).val()},function (data) {
                alert(data.errorMsg);
                getOrder($("#oCurrentPage").text());
            });
        }

        function getOrder(currentPage){
            $.post("order/pageQuery",{"uid":$("#uid").text(),"orderCurrentPage":currentPage},function (data){//
                var trs="";
                var list=data.list;
                $("#oCurrentPage").text(data.currentPage);
                $("#oToalPage").text(data.totalPage);
                for(var i=0;i<list.length;i++) {
                    if(list[i].status=="-1"){
                        var tr='<tr><td>'+list[i].orderId+'</td> <td>'+list[i].startCity+'</td> <td>'+list[i].arriveCity+'</td><td>'+list[i].startDateTime+'</td> <td> <button type="button" class="btn btn-default disabled" value="'+list[i].orderId+'" >已过期</button></td></tr>';
                    }else if(list[i].status=="1"){
                        var tr='<tr><td>'+list[i].orderId+'</td> <td>'+list[i].startCity+'</td> <td>'+list[i].arriveCity+'</td><td>'+list[i].startDateTime+'</td> <td> <button type="button" class="btn btn-danger" value="'+list[i].orderId+'" onclick="cancelOrder(this)">退订</button></td></tr>';
                    }else if(list[i].status=="0"){
                        var tr='<tr><td>'+list[i].orderId+'</td> <td>'+list[i].startCity+'</td> <td>'+list[i].arriveCity+'</td><td>'+list[i].startDateTime+'</td> <td> <button type="button" class="btn btn-info disabled" value="'+list[i].orderId+'" >已退订</button></td></tr>';
                    }
                    trs+=tr;
                }
                $("#obody").html(trs);
            });
        }

        $(function () {
            $("#myReservation").click(function () {
                getOrder();
            });
        });

        //上一页
        $(function () {
            $("#oPrevious").click(function () {
                var pre=Number($("#oCurrentPage").text());
                if(pre > 1)
                {
                    getOrder(pre-1);
                }
            });
        });

        //下一页
        $(function () {
            $("#oNext").click(function () {
                var next=Number($("#oCurrentPage").text());
                if(next < Number($("#oToalPage").text())){
                    getOrder(next+1);
                }
            });
        });
    </script>
    
    
    <script type="text/javascript">
        function callBackUser(){
            $("#username").val($("#u01").val());
            $("#password").val($("#u02").val());
            $("#truthName").val($("#u03").val());
            $("#telephone").val($("#u04").val());
            $("#identity").val($("#u05").val());
        }
        $(function () {
            $("#personalEdit").click(function () {
                callBackUser();
            });
        });

       /* $.ajaxSetup({
            async : false
        });*/
        function checkUsername() {
            var username=$("#username").val();
            var reg_username = /^\w{3,10}$/;
            var flag=reg_username.test(username);
            if(flag)
            {
                $("#form-group1").removeClass("has-error");
            }else {
                $("#form-group1").addClass("has-error");
                $("#tip01").text("用户名长度在3-10之间！");
            }
            return flag;
        }
        //校验密码
        function checkPassword() {
            //1.获取密码值
            var password = $("#password").val();
            //2.定义正则
            var reg_password = /^\w{6,20}$/;
            //3.判断，给出提示信息
            var flag = reg_password.test(password);
            if(flag){
                $("#form-group2").removeClass("has-error");
            }else{
                $("#form-group2").addClass("has-error");
                $("#tip02").text("密码长度在3-10之间！");
            }
            return flag;
        }
        //校验确认密码
        function checkConfirmPassword() {
            var password = $("#password").val();
            var confirmPassword=$("#confirmPassword").val();
            var flag=false;
            if($.trim(password) == $.trim(confirmPassword)){
                flag=true;
                $("#form-group3").removeClass("has-error");
            }else {
                $("#form-group3").addClass("has-error");
                $("#tip03").text("两次密码不一致！");
            }
            return flag;
        }

        function checkTruthName() {
            var length=$("#truthName").val().length;
            var flag=false;
            if(eval(length) < eval(5)||eval(length) > eval(1))
            {
                flag=true;
                $("#form-group4").removeClass("has-error");
            }else {
                $("#form-group4").addClass("has-error");
                $("#tip04").text("真实姓名在2-4之间！");
            }
            return flag;
        }

        function checkTelephone(){
            var tel=$("#telephone").val();
            var reg_tel=/^1[3456789]\d{9}$/;
            var flag=reg_tel.test(tel);
            if(flag){
                $("#form-group5").removeClass("has-error");
            }else {
                $("#form-group5").addClass("has-error");
                $("#tip05").text("手机号不正确！");
            }
            return flag;
        }
        function checkIdentity(){
            var identity=$("#identity").val().length;
            var flag=false;
            if(identity==18)
            {
                flag=true;
                $("#form-group6").removeClass("has-error");
            }else {
                $("#form-group6").addClass("has-error");
                $("#tip06").text("身份证号不正确！");
            }
            return flag;
        }

        $(function () {
            $("#editForm").submit(function () {
                if(checkUsername()&&checkPassword()&&checkConfirmPassword()&&checkTruthName()&&checkTelephone()&&checkIdentity())
                {
                    $.post("user/editUser",$(this).serialize(),function (data){
                        if(data.flag==false){
                            alert(data.errorMsg);
                        }
                        callBackUser();
                        window.location.reload()
                    });
                }
                return false;
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
                <li id="myhome"><a href="#home">首页</a></li>
                <li id="myReservation"><a href="#reservation">我的订单</a></li>
                <li id="personalEdit"><a href="#personalCenter">个人中心</a></li>
                <li><button type="button" class="btn btn-danger" style="margin-top: 360px;" data-toggle="modal" data-target="#exitmodal">退出登录</button></li>
            </ul>
        </div>
        <div class="col-md-9" style="height:100%;background-color: #e7e7e7;">
            <div class="tab-content">
                <div class="tab-pane active" id="home">
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
                                        ,max:3
                                        ,showBottom: false
                                        ,theme:'#337AB7'
                                        ,done: function(value, date){
                                            load();
                                        }
                                    });
                                </script>
                            </div>
                            <button type="submit" class="btn btn-primary">查询</button>
                        </form>
                    </div>
                    <div class="row" style="height: 400px;">
                        <table class="table table-hover table-condensed table-bordered">
                            <thead>
                            <tr>
                                <th>发车时间</th>
                                <th>票价</th>
                                <th>余票</th>
                                <th>订票</th>
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
                <div class="tab-pane fade" id="reservation">
                    <div class="row" style="height: 435px;margin-top: 50px">
                        <table class="table table-hover table-condensed table-bordered">
                            <thead>
                            <tr>
                                <th>订单编号</th>
                                <th>出发城市</th>
                                <th>到达城市</th>
                                <th>发车日期</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="obody">
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <nav aria-label="Page navigation" style="width: 90%;margin-left:5%;">
                            <ul class="pager">
                                <li class="previous" id="oPrevious"><a href="#"><span aria-hidden="true">上一页</span></a></li>
                                <li><span>第<span id="oCurrentPage">0</span>页</span></li>
                                <li><span>共<span id="oToalPage">0</span>页</span></li>
                                <li class="next" id="oNext"><a href="#"><span aria-hidden="true">下一页</span></a></li>
                            </ul>
                        </nav>
                    </div>
                </div>
                <div class="tab-pane fade" id="personalCenter">
                    <div class="row" style="margin-top: 60px;">
                        <form class="form-horizontal col-sm-offset-3" id="editForm">
                            <div class="form-group hidden">
                                <label class="col-sm-2 control-label">账号</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="uid" placeholder="账号" value="${user.uid}">
                                </div>
                            </div>
                            <div class="form-group" id="form-group1">
                                <label class="col-sm-2 control-label">用户名</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="username" id="username" placeholder="用户名">
                                    <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip01"></div>
                                </div>
                            </div>
                            <div class="form-group" id="form-group2">
                                <label class="col-sm-2 control-label">密码</label>
                                <div class="col-sm-4">
                                    <input type="password" class="form-control" name="password" id="password" placeholder="密码">
                                    <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip02"></div>
                                </div>
                            </div>
                            <div class="form-group" id="form-group3">
                                <label class="col-sm-2 control-label">确认密码</label>
                                <div class="col-sm-4">
                                    <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="确认密码">
                                    <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip03"></div>
                                </div>
                            </div>
                            <div class="form-group" id="form-group4">
                                <label class="col-sm-2 control-label">真实姓名</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="truthName" id="truthName" placeholder="真实姓名">
                                    <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip04"></div>
                                </div>
                            </div>
                            <div class="form-group" id="form-group5">
                                <label class="col-sm-2 control-label">手机号</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="telephone" id="telephone" placeholder="手机号">
                                    <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip05"></div>
                                </div>
                            </div>
                            <div class="form-group" id="form-group6">
                                <label class="col-sm-2 control-label">身份证号</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" name="identity" id="identity" placeholder="身份证号">
                                    <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip06"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-2">
                                    <button type="submit" class="btn btn-primary">修改</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
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
