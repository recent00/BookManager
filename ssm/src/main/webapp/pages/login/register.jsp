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
<div class="modal fade" id="register" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" >
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">读者注册</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="readerName">姓名</label>
                        <input type="text" class="form-control" id="readerName" placeholder="请输入您的姓名">
                    </div>
                    <div class="form-group">
                        <label for="readerPwd">密码</label>
                        <input type="password" class="form-control" id="readerPwd" placeholder="请输入密码">
                    </div>
                    <div class="form-group">
                        <label for="rePasswd">重复输入密码</label>
                        <input type="password" class="form-control" id="rePasswd" placeholder="请重复输入密码">
                    </div>
                    <div class="form-group">
                        <label for="phone">手机号</label>
                        <input type="text" class="form-control" id="phone" placeholder="请重复输入您要绑定的手机号">
                    </div>
                    <div class="form-group">
                        <label class="radio-inline">
                            <input type="radio" name="sex" id="gender1_update_input" value=1 checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="sex" id="gender2_update_input" value=0> 女
                        </label>
                    </div>

                    <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
                    <button type="button" id="registerButton"  class="btn btn-primary  btn-block">注册</button>
                    <button type="button" id="returnButton"  class="btn btn-primary  btn-block">返回</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $("#returnButton").click(function () {
            window.location.href="${ctp}/pages/login/login.jsp";
        })
        $("#registerButton").click(function () {
            var readerName=$("#readerName").val();
            var readerPwd=$("#readerPwd").val();
            var regPwd = /(^[a-zA-Z0-9_-]{6,16}$)/;
            var rePasswd=$("#rePasswd").val();
            var phone = $("#phone").val();
            var regPhone = /^1\d{10}$/;
            $("#info").text("");
            if (readerName == '') {
                $("#info").text("提示:姓名不能为空");
            }
            else if( readerPwd ==''){
                $("#info").text("提示:密码不能为空");
            }
            else if(!regPwd.test(readerPwd)){
                $("#info").text("提示:密码应是6-16位英文和数字的组合");
            }
            else if(readerPwd!=rePasswd){
                $("#info").text("提示:两次输入的密码不一致");
            }
            else if(phone == ""){
                $("#info").text("提示:手机号不能为空");
            }
            else if(!regPhone.test(phone)){
                $("#info").text("提示:手机号不合法");
            }
            else {
                $.ajax({
                    type:"POST",
                    url:"${ctp}/register",
                    data:$("#register form").serialize(),
                    success:function (data) {

                    }
                })
            }
        })
    })

</script>

</body>
</html>
