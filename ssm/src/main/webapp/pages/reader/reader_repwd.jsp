<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/16
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>修改密码</title>
    <%@include file="/pages/common/head.jsp"%>
</head>

<body background="${ctp}/static/img/book2.jpg" style=" background-repeat:no-repeat ;background-size:100% 100%;background-attachment: fixed;">
<div class="panel panel-default" id="rePasswd">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">修改密码</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
                <label for="oldPwd">输入旧密码</label>
                <input type="text" class="form-control" id="oldPwd" placeholder="请输入旧密码">
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
    <style>
        .panel{
            height: 400px;
            width: 400px;
            position: absolute;
            top: 100px;
            right: 600px;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            $("#certainButton").click(function () {
                var oldPwd = $("#oldPwd").val();
                var newPwd = $("#newPwd").val();
                var rePwd = $("#rePwd").val();
                var testPwd = /(^[a-zA-Z0-9_-]{6,16}$)/;
                $("#info").text("");
                if (oldPwd == '') {
                    $("#info").text("提示:密码不能为空");
                }
                else if( newPwd ==''){
                    $("#info").text("提示:密码不能为空");
                }else if(!testPwd.test(newPwd)){
                    $("#info").text("提示:密码应是6-16位英文和数字的组合");
                }else if(rePwd != newPwd){
                    $("#info").text("提示:两次输入密码不一致");
                }else {
                    $.ajax({
                        type:"PUT",
                        url:"${ctp}/reader_changePwd",
                        data:{
                            "oldPwd":oldPwd,
                            "newPwd":newPwd
                        },
                        success:function (data) {
                            if(data.code==100){
                                alert("密码修改成功");
                                window.location.href = "${ctp}/pages/reader/reader_main.jsp";
                            }else {
                                $("#info").text(data.extend.msg);
                            }
                        }
                    })
                }
            })
            $("#returnButton").click(function () {
                window.location.href="${ctp}/pages/reader/reader_main.jsp";
            })
        })
    </script>
</div>
</body>
</html>
