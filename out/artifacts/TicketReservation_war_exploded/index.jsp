<%--
  Created by IntelliJ IDEA.
  User: wlk
  Date: 2019/10/9
  Time: 14:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>车票预定系统-登录</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery-3.4.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#login").click(function () {
                $.post("user/login",$("#loginForm").serialize(),function (data) {
                    if(data.flag)
                    {
                        if(data.errorMsg=="1"){
                            location.href="${pageContext.request.contextPath}/admin.jsp";
                        }else {
                            location.href="${pageContext.request.contextPath}/main.jsp";
                        }
                    }else{
                        $("#tips").text(data.errorMsg);
                    }
                });
            });
        });
    </script>
</head>
<body style="background: #353f42;">
<div class="container">
    <div class="row" style="margin-top:150px;">
        <div class="col-md-offset-4 col-md-4" style="background-color: white;height:400px;">
            <form id="loginForm" class="form-horizontal" method="post">
                <div class="form-group">
                    <h4 style="margin-top:20px;margin-left: 15px">密码登录</h4>
                </div>
                <div class="form-group">
                    <div style="margin-top:20px;margin-left:15px;font-size: smaller; color: #9d9d9d">请输入用户名和密码</div>
                </div>
                <div class="form-group">
                    <div class="col-md-12" style="margin-top: 10px">
                        <input type="text" class="form-control" placeholder="用户名" name="username">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-12" >
                        <input type="password" class="form-control" id="inputPassword3" placeholder="密码" name="password">
                    </div>
                </div>
                <div class="form-group" style="margin-top: 30px">
                    <button class="col-md-offset-1 col-md-10 btn btn-primary" type="button" id="login">登录</button>
                </div>
                <div style="font-size:smaller;color: red;text-align: center;height: 0px;" id="tips">${requestScope.login_error}</div>
                <div class="form-group" style="margin-top: 35px;color: #9d9d9d">
                    <a href="register.jsp"><button type="button" class="btn btn-link btn-xs col-md-3 col-md-offset-9">注册账户</button></a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
