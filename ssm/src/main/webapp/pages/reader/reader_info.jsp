<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${reader.readerName}的主页</title>
    <%@include file="/pages/common/head.jsp"%>
    <script>
        $(function () {
            $('#header').load('${ctp}/pages/reader/reader_header.jsp');
        })
    </script>
</head>
<body background="${ctp}/static/img/lizhi.jpg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<div id="header"></div>
<div class="modal fade" id="rePhone" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" >
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">手机号修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <div class="col-sm-12">
                            <label>读者证号:${reader.readerId}</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <label>姓名:${reader.readerName}</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <label>性别:${reader.sex == 1?"男":"女"}</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <label for="phone">手机号</label>
                            <input type="text" class="form-control" id="phone" placeholder="请输入您要修改的手机号" name="phone">
                        </div>
                    </div>
                    <p style="text-align: right;color: red;position: absolute" id="info"></p><br/>
                    <button type="button" id="updateButton11"  class="btn btn-primary  btn-block">修改</button>
                    <button type="button" id="closeModal" data-dismiss="modal"  class="btn btn-primary  btn-block">关闭</button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="col-xs-5 col-md-offset-3">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
                我的信息
            </h3>
        </div>
        <div class="panel-body">
            <table class="table table-hover">
                <tr>
                    <th width="20%">读者证号</th>
                    <td>${reader.readerId}</td>
                </tr>
                <tr>
                    <th>姓名</th>
                    <td>${reader.readerName}</td>
                </tr>
                <tr>
                    <th>性别</th>
                    <td>${reader.sex == 1?"男":"女"}</td>
                </tr>
                <tr>
                    <th>电话</th>
                    <td>${reader.phone}</td>
                </tr>
                </tbody>
            </table>
        </div>
        <button class="btn btn-success btn-sm" id="update">修改</button>
        <a class="btn" href="${ctp}/pages/reader/reader_main.jsp" role="button">返回</a>
    </div>
    <style>
        .panel{
            height: 300px;
            width: 450px;
            position: absolute;
            top: 150px;
            left: 200px;
        }
    </style>
    <script type="text/javascript">

        $("#update").click(function () {
            //弹出模态框
            $("#rePhone").modal({
                backdrop: "static"//点击背景不消失
            })
        })
        $(function () {
            $("#updateButton11").click(function () {
                var phone = $("#phone").val();
                $("#info").text("");
                if(phone==""){
                    $("#info").text("手机号不能为空");
                }
                $.ajax({
                    type:"PUT",
                    url:"${ctp}/updatePhone",
                    data:{
                        readerId:${reader.readerId},
                        phone:phone
                    },
                    success:function (result) {
                        if(result.code==100){
                            alert("修改成功");
                            $("#rePhone").modal('hide');
                            window.location.href="${ctp}/pages/reader/reader_info.jsp";
                        }else {
                            $("#info").text(result.extend.msg);
                        }
                    }
                })
            })
        })

    </script>
</div>


</body>
</html>
