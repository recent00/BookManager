<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>图书馆首页</title>
    <%--静态包含 jQuary文件、bootstrap文件--%>
    <%@include file="/pages/common/head.jsp"%>
    <script src="${ctp}/static/js/js.cookie.js"></script>
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
                        <div class="col-sm-12">
                            <label for="readerName">姓名</label>
                            <input type="text" class="form-control" id="readerName" placeholder="请输入您的姓名" name="readerName">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <label for="readerPwd">密码</label>
                            <input type="password" class="form-control" id="readerPwd" placeholder="请输入密码" name="readerPwd">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <label for="rePasswd">重复输入密码</label>
                            <input type="password" class="form-control" id="rePasswd" placeholder="请重复输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <label for="phone">手机号</label>
                            <input type="text" class="form-control" id="phone" placeholder="请重复输入您要绑定的手机号" name="phone">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="gender1_update_input" value=1 checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" id="gender2_update_input" value=0> 女
                            </label>
                        </div>
                    </div>

                    <p style="text-align: right;color: red;position: absolute" id="info1"></p><br/>
                    <button type="button" id="registerButton1"  class="btn btn-primary  btn-block">注册</button>
                    <button type="button" data-dismiss="modal"  class="btn btn-primary  btn-block">返回</button>
                </form>
            </div>
        </div>
    </div>
</div>

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

        <div class="item-inner">
            <label>验证码：</label>
            <input class="itxt" type="text" style="width: 80px;" name="code" id="code" value=""/>
            <img  alt="" src="http://localhost:8080/SSM-CRUD/kaptcha.jpg"  style="width: 100px; height: 28px;" id="code_id">
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

            //验证码点击切换图片
            $("#code_id").click(function () {
                // 在事件响应的 function 函数中有一个 this 对象。这个 this 对象，是当前正在响应事件的 dom 对象
                // src 属性表示验证码 img 标签的 图片路径。它可读，可写
                this.src = "http://localhost:8080/SSM-CRUD/kaptcha.jpg?d=" + new Date();
            })
            // 记住登录信息  30天有效期
            function rememberLogin(username, password, checked) {
                Cookies.set('loginStatus', {
                    username: username,
                    password: password,
                    remember: checked
                }, {expires: 30, path: ''})
            }
            // 若选择记住登录信息，则进入页面时设置登录信息
            function setLoginStatus() {
                var loginStatusText = Cookies.get('loginStatus');
                if (loginStatusText) {
                    var loginStatus;
                    try {
                        loginStatus = JSON.parse(loginStatusText);
                        $('#id').val(loginStatus.username);
                        $('#passwd').val(loginStatus.password);
                        $("#remember").prop('checked',loginStatus.remember);
                    } catch (__) {}
                }
            }
            // 设置登录信息
            setLoginStatus();
            $("#loginButton").click(function () {
                var id =$("#id").val();
                var password=$("#passwd").val();
                var remember=$("#remember").prop('checked');
                var code = $("#code").val();
                $("#info").text("");
                if (id == '') {
                    $("#info").text("提示:账号不能为空");
                }
                else if( password ==''){
                    $("#info").text("提示:密码不能为空");
                }else if(code == ""){
                    $("#info").text("提示:验证码不能为空");
                }
                else if(isNaN( id )){/!*用于检查其参数是否是非数字值。*!/
                    $("#info").text("提示:账号必须为数字");
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "${ctp}/loginCheck",
                        data:{
                            "id":id,
                            "password":password,
                            "code": code
                        },
                        success:function (data) {
                            if(data.code==100){
                                if(data.extend.admin){
                                    $("#info").text("提示:管理员登陆成功，跳转中...");
                                    window.location.href="${ctp}/pages/admin/admin_main.jsp";
                                }else if(data.extend.reader){
                                    if(remember){
                                        rememberLogin(id,password,true);
                                    }else {
                                        Cookies.set('loginStatus', {
                                        }, {expires: 0, path: ''});
                                    }
                                    $("#info").text("提示:普通读者登陆成功，跳转中...");
                                    window.location.href="${ctp}/pages/reader/reader_main.jsp";
                                }
                            }else {
                                document.getElementById("code_id").src = "http://localhost:8080/SSM-CRUD/kaptcha.jpg?d=" + new Date();
                                $("#info").text(data.extend.msg);
                            }
                        }
                    })
                }
            })

            //清空表单样式及内容
            function reset_form(ele){
                //清空表单内容
                $(ele)[0].reset();
                //清空表单错误提示信息
                $(ele).find("#info1").text(" ");
            }

            $("#registerButton").click(function () {
                //window.location.href="${ctp}/pages/login/register.jsp";
                //清空模态框里面的数据
                reset_form("#register form");
                //弹出模态框
                $("#register").modal({
                    backdrop:"static"//点击背景不消失
                })
            })

            $("#registerButton1").click(function () {
                var readerName=$("#readerName").val();
                var readerPwd=$("#readerPwd").val();
                var regPwd = /(^[a-zA-Z0-9_-]{6,16}$)/;
                var rePasswd=$("#rePasswd").val();
                var phone = $("#phone").val();
                var regPhone = /^1\d{10}$/;
                $("#info1").text("");
                if (readerName == '') {
                    $("#info1").text("提示:姓名不能为空");
                }
                else if( readerPwd ==''){
                    $("#info1").text("提示:密码不能为空");
                }
                else if(!regPwd.test(readerPwd)){
                    $("#info1").text("提示:密码应是6-16位英文和数字的组合");
                }
                else if(readerPwd!=rePasswd){
                    $("#info1").text("提示:两次输入的密码不一致");
                }
                else if(phone == ""){
                    $("#info1").text("提示:手机号不能为空");
                }
                else if(!regPhone.test(phone)){
                    $("#info1").text("提示:手机号不合法");
                }
                else {
                    $.ajax({
                        type:"POST",
                        url:"${ctp}/register",
                        data:$("#register form").serialize(),
                        success:function (data) {
                            if(data.code==100){
                                alert("注册成功，您的读者证号为:"+data.extend.readerId);
                                $("#register").modal('hide');
                            }else{
                                if(data.extend.info){
                                    $("#info1").text(data.extend.info);
                                }else {
                                    if(undefined!=data.extend.errorFields.readerPwd){
                                        $("#info1").text(data.extend.errorFields.readerPwd);
                                    }
                                    if(undefined!=data.extend.errorFields.phone){
                                        $("#info1").text(data.extend.errorFields.phone);
                                    }
                                }

                            }
                        }
                    })
                }
            })
        })

    </script>
</div>
</body>
</html>

