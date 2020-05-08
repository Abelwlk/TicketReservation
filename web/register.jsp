<%--
  Created by IntelliJ IDEA.
  User: 
  Date: 2019/10/9
  Time: 17:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>车票预定系统-注册</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $.ajaxSetup({
            async : false
        });
        function checkUsername() {
            var username=$("#username").val();
            var reg_username = /^\w{3,10}$/;
            var flag=reg_username.test(username);
            if(flag)
            {
                $.post("user/register",{"username":username},function (data){
                    if(data.flag==false)
                    {
                        $("#form-group1").addClass("has-error");
                        $("#tip01").text(data.errorMsg);
                        flag=false;
                    }else {
                        $("#form-group1").removeClass("has-error");
                    }
                });
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
                $("#tip02").text("密码长度在6-20之间！");
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
            $("#registerForm").submit(function () {
                if(checkUsername()&&checkPassword()&&checkConfirmPassword()&&checkTruthName()&&checkTelephone()&&checkIdentity())
                {
                    $.post("user/register",$(this).serialize(),function (data){
                        if(data.flag)
                        {
                            location.href="${pageContext.request.contextPath}/index.jsp";
                        }else {
                            $("#tips").text("注册失败！");
                        }
                    });
                }else {
                    $("#tips").text("表单错误！");
                }
                return false;
            });
        });

    </script>
</head>
<body style="background: #353f42;">
<div class="container">
    <div class="row" style="margin-top:80px;">
        <div class="col-md-offset-4 col-md-4" style="background-color: white;height:580px;">
            <form id="registerForm" class="form-horizontal" >
                <div class="form-group">
                    <h4 style="margin-top:20px;margin-left: 15px">新用户注册</h4>
                </div>
                <div class="form-group">
                    <div style="margin-top:20px;margin-left:15px;font-size: smaller; color: #9d9d9d">请输入用户名和密码</div>
                </div>
                <div class="form-group" id="form-group1">
                    <div class="col-md-12" style="margin-top: 10px">
                        <input id="uid" type="hidden" name="uid" value="0">
                        <input type="text" class="form-control" placeholder="用户名" name="username" id="username">
                        <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip01"></div>
                    </div>
                </div>
                <div class="form-group" id="form-group2">
                    <div class="col-md-12" >
                        <input type="password" class="form-control" placeholder="密码" name="password" id="password">
                        <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip02"></div>
                    </div>
                </div>
                <div class="form-group" id="form-group3">
                    <div class="col-md-12" >
                        <input type="password" class="form-control" placeholder="确认密码" name="confirmPassword" id="confirmPassword">
                        <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip03"></div>
                    </div>
                </div>
                <div class="form-group" id="form-group4">
                    <div class="col-md-12">
                        <input type="text" class="form-control" name="truthName" placeholder="真实姓名" id="truthName">
                        <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip04"></div>
                    </div>
                </div>
                <div class="form-group" id="form-group5">
                    <div class="col-md-12">
                        <input type="text" class="form-control" name="telephone" placeholder="手机号" id="telephone">
                        <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip05"></div>
                    </div>
                </div>
                <div class="form-group" id="form-group6">
                    <div class="col-md-12">
                        <input type="text" class="form-control" name="identity" placeholder="身份证号" id="identity">
                        <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tip06"></div>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 30px">
                    <button class="col-md-offset-1 col-md-10 btn btn-primary" type="submit">注册</button>
                </div>
                <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tips"></div>
                <div class="form-group" style="margin-top: 35px;color: #9d9d9d">
                    <a href="index.jsp"><button type="button" class="btn btn-link btn-xs col-md-4 col-md-offset-8">已有账号,去登录</button></a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
