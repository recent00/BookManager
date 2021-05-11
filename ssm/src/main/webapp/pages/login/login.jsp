<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <h3 class="panel-title">请登录</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="id">账号</label>
            <input type="text" class="form-control" id="id" placeholder="请输入账号">
        </div>
        <div class="form-group">
            <label for="passwd">密码</label>
            <input type="password" class="form-control" id="passwd" placeholder="请输入密码">
        </div>
        <div class="checkbox text-left">
            <label>
                <input type="checkbox" id="remember">记住密码
            </label>
        </div>

        <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
        <button id="loginButton"  class="btn btn-primary  btn-block">登陆</button>
        <button id="registerButton"  class="btn btn-primary  btn-block">注册</button>
    </div>
    <script type="text/javascript">
        $("#id").keyup(/*判断输入的值是否为数字*/
            function () {
                if(isNaN($("#id").val())){
                    $("#info").text("提示:账号只能为数字");
                }
                else {
                    $("#info").text("");
                }
            }
        )
        $(function () {
            $("#loginButton").click(function () {
                var id =$("#id").val();
                var password=$("#passwd").val();
                var remember=$("#remember").prop('checked');
                $("#info").text("");
                if (id == '') {
                    $("#info").text("提示:账号不能为空");
                }
                else if( password ==''){
                    $("#info").text("提示:密码不能为空");
                }
                else if(isNaN( id )){/!*用于检查其参数是否是非数字值。*!/
                    $("#info").text("提示:账号必须为数字");
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "${ctp}/loginCheck",
                        data:{
                            "id":id,"password":password
                        },
                        success:function (data) {
                            if(data.code==100){
                                if(data.extend.adminName){
                                    $("#info").text("提示:管理员登陆成功，跳转中...");
                                    window.location.href="${ctp}/pages/admin/admin_main.jsp";
                                }else if(data.extend.readerName){
                                    $("#info").text("提示:普通读者登陆成功，跳转中...");
                                    window.location.href="${ctp}/pages/reader/reader_main.jsp";
                                }
                            }else {
                                $("#info").text(data.extend.msg);
                            }
                        }
                    })
                }
            })
            $("#registerButton").click(function () {
                window.location.href="${ctp}/pages/login/register.jsp";
            })
        })

    </script>
</div>
</body>
</html>

