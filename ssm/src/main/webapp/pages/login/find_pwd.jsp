<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/31
  Time: 15:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>找回密码</title>
    <%--静态包含 jQuary文件、bootstrap文件--%>
    <%@include file="/pages/common/head.jsp"%>
    <style>
        #find_pwd{
            height: 60%;
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
<body background="${ctp}/static/img/sky.jpg" style=" background-repeat:no-repeat ;background-size:100% 100%;background-attachment: fixed;">
<h2 style="text-align: center; color: white; font-family: '华文行楷'; font-size: 500%">图 书 馆</h2>
<div class="panel panel-default" id="find_pwd">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">找回密码</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="id">账号</label>
            <input type="text" class="form-control" id="id" placeholder="请输入账号">
        </div>
        <div class="form-group">
            <label for="phone">手机号</label>
            <input type="text" class="form-control" id="phone" placeholder="请输入手机号">
        </div>
        <div class="item-inner">
            <a href="#" onclick="getCode();return false;">获取验证码</a>
            <input class="itxt" type="text" style="width: 80px;" name="code" id="code" value=""/>
        </div>
        <div class="form-group">
            <label for="newPwd">输入新密码</label>
            <input type="password" class="form-control" id="newPwd" placeholder="请输入新密码">
        </div>
        <div class="form-group">
            <label for="rePwd">再次输入新密码</label>
            <input type="password" class="form-control" id="rePwd" placeholder="请再次输入新密码">
        </div>
        <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
        <button id="certainButton"  class="btn btn-primary  btn-block">确定</button>
        <button id="returnButton"  class="btn btn-primary  btn-block">返回</button>
    </div>
    <script type="text/javascript">
        $(function () {
            $("#returnButton").click(function () {
                window.location.href="${ctp}/pages/login/login.jsp";
            })
            $("#certainButton").click(function () {
                var userId = $("#id").val();
                var phone = $("#phone").val();
                var code = $("#code").val();
                var newPwd = $("#newPwd").val();
                var rePwd = $("#rePwd").val();
                var testPwd = /(^[a-zA-Z0-9_-]{6,16}$)/;
                $("#info").text("");
                if(userId == ''){
                    $("#info").text("提示:账号不能为空");
                }else if(phone == ''){
                    $("#info").text("提示:手机号不能为空");
                }else if(code == ''){
                    $("#info").text("提示:验证码不能为空");
                }else if( newPwd ==''){
                    $("#info").text("提示:密码不能为空");
                }else if(!testPwd.test(newPwd)){
                    $("#info").text("提示:密码应是6-16位英文和数字的组合");
                }else if(rePwd != newPwd){
                    $("#info").text("提示:两次输入密码不一致");
                }else {
                    $.ajax({
                        type:"PUT",
                        url:"${ctp}/forgetPwd",
                        data:{
                            "id":userId,
                            "phone":phone,
                            "code":code,
                            "newPwd":newPwd
                        },
                        success:function (data) {
                            if(data.code==100){
                                alert("密码修改成功");
                                window.location.href = "${ctp}/pages/login/login.jsp";
                            }else {
                                $("#info").text(data.extend.msg);
                            }
                        }
                    })
                }
            })
        })
        function getCode() {
            var phone = $("#phone").val();
            var userId = $("#id").val();
            $("#info").text("");
            if (userId == '') {
                $("#info").text("提示:账号不能为空");
            }
            if(phone == ''){
                $("#info").text("提示:手机号不能为空");
            }
            $.ajax({
                type:"GET",
                url: "${ctp}/getCode",
                data:{
                    "id":userId,
                    "phone":phone
                },
                success:function (result) {
                    $("#info").text(result.extend.msg);
                }
            })
        }
    </script>
</div>
</body>
</html>
