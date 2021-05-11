<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/9
  Time: 16:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书馆首页</title>
    <%--静态包含 jQuary文件、bootstrap文件--%>
    <%@include file="/pages/common/head.jsp"%>
    <style>
        #login{
            height: 50%;
            width: 28%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 5%;
            display: block;
            position: center;
        }

        .form-group {
            margin-bottom: 0;
        }
        * {
            padding:0;
            margin:0;
        }
    </style>
</head>
<body background="${ctp}/static/img/timg.jpg" style=" background-repeat:no-repeat ;background-size:100% 100%;background-attachment: fixed;">
<h2 style="text-align: center; color: white; font-family: '华文行楷'; font-size: 500%">图 书 馆</h2>
<div class="panel panel-default" id="login">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">请注册</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="id">姓名</label>
            <input type="text" class="form-control" id="id" placeholder="请输入您的姓名">
        </div>
        <div class="form-group">
            <label for="passwd">密码</label>
            <input type="password" class="form-control" id="passwd" placeholder="请输入密码">
        </div>
        <div class="form-group">
            <label for="rept_passwd">重复输入密码</label>
            <input type="password" class="form-control" id="rept_passwd" placeholder="请重复输入密码">
        </div>
        <div class="form-group">
            <label for="phone">手机号</label>
            <input type="text" class="form-control" id="phone" placeholder="请重复输入您要绑定的手机号">
        </div>
        <div class="form-group">
            <label class="radio-inline">
                <input type="radio" name="gender" id="gender1_update_input" value=1 checked="checked"> 男
            </label>
            <label class="radio-inline">
                <input type="radio" name="gender" id="gender2_update_input" value=0> 女
            </label>
        </div>

        <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
        <button id="loginButton"  class="btn btn-primary  btn-block">注册</button>
        <button id="returnButton"  class="btn btn-primary  btn-block">返回</button>
    </div>

    <script type="text/javascript">
        $(function () {
            $("#returnButton").click(function () {
                window.location.href="${ctp}/pages/login/login.jsp";
            })
        })

    </script>
</div>
</body>
</html>
