<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/pages/common/head.jsp"%>


<!-- 图书添加模态框 -->
<div class="modal fade" id="bookAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document" >
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">图书添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="bookName_add_input" class="col-sm-2 control-label">图书名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="bookName_add_input" placeholder="输入图书名称" name="bookName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="author_add_input" class="col-sm-2 control-label">作者</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="author_add_input" placeholder="输入图书作者" name="author">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="publish_add_input" class="col-sm-2 control-label">出版社</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="publish_add_input" placeholder="输入图书出版社" name="publish">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="isbn_add_input" class="col-sm-2 control-label">ISBN</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="isbn_add_input" placeholder="输入图书ISBN" name="isbn">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="price_add_input" class="col-sm-2 control-label">价格</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="price_add_input" placeholder="输入图书价格" name="price">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="number_add_input" class="col-sm-2 control-label">剩余数量</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="number_add_input" placeholder="输入图书数量" name="number">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal" id="close_btn">关闭</button>
                <button type="button" class="btn btn-primary" id="book_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>


<nav style="position:fixed;z-index: 999;width: 100%;background-color: #25c6fc" class="navbar navbar-default"
     role="navigation">
    <div class="container-fluid">
        <div class="navbar-header" style="margin-left: 8%;margin-right: 1%">
            <a class="navbar-brand" href="${ctp}/pages/admin/admin_main.jsp" style="font-family: 华文行楷; font-size: 250%; color: white">图书管理系统</a>
        </div>
        <div class="collapse navbar-collapse" >
            <ul class="nav navbar-nav navbar-left">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: white">
                        图书管理
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="${ctp}/pages/admin/admin_main.jsp">全部图书</a></li>
                        <li class="divider"></li>
                        <li><a href="#" onclick="addBook()">增加图书</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="color: white">
                        借还管理
                        <b class="caret"></b>
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="lendlist.html">借还审理</a></li>
                        <li class="divider"></li>
                        <li><a href="lendlist.html">借还日志</a></li>
                    </ul>
                </li>
                <li >
                    <a href="${ctp}/pages/admin/admin_repwd.jsp" style="color: white">
                        密码修改
                    </a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="login.html" style="color: white">${admin.adminName}, 已登录</a>
                </li>
                <li><a href="${ctp}/logout" style="color: white">退出</a></li>
            </ul>
        </div>
    </div>
</nav>



<script type="text/javascript">
    $('.dropdown-toggle').dropdown();
    function addBook() {
        //弹出模态框
        $("#bookAddModal").modal({
            backdrop:"static"//点击背景不消失
        })
    }

    //清空表单样式及内容
    function reset_form(ele){
        //清空表单内容
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        //清空表单错误提示信息
        $(ele).find(".help-block").text(" ");
    }

    function show_validate_msg(ele,status,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if(status=="success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if(status == "error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验表单数据
    function validate_add_form(){
        var price = $("#price_add_input").val();
        var regPrice = /^[1-9]?\d*(\.\d{1,2})?$/;
        if(!regPrice.test(price)){
            show_validate_msg("#price_add_input","error","输入的价格不合法");
            return false;
        }else {
            show_validate_msg("#price_add_input","success","");
        }
        var number = $("#number_add_input").val();
        var regNumber = /(^[0-9]{1,8}$)/;
        if(!regNumber.test(number)){
            show_validate_msg("#number_add_input","error","输入的数量不合法");
            return false;
        }else {
            show_validate_msg("#number_add_input","success","");
        }
        var author = $("#author_add_input").val();
        if(author == ""){
            show_validate_msg("#author_add_input","error","作者姓名不能为空");
            return false;
        }
        var publish = $("#publish_add_input").val();
        if(publish == ""){
            show_validate_msg("#publish_add_input","error","出版社不能为空");
            return false;
        }
        return true;
    }

    $(function () {
        //校验图书名是否可用
        $("#bookName_add_input").change(function () {
            var bookName = this.value;
            $.ajax({
                url:"${ctp}/checkbook",
                data:"bookName="+bookName,
                type:"POST",
                success:function (result) {
                    if(result.code==100){
                        show_validate_msg("#bookName_add_input","success","合法图书");
                        $("#book_save_btn").attr("ajax-va","success");
                    }else {
                        show_validate_msg("#bookName_add_input","error",result.extend.va_msg);
                        $("#book_save_btn").attr("ajax-va","error");
                    }
                }
            })
        })

        //校验ISBN
        $("#isbn_add_input").change(function () {
            var isbn = this.value;
            var regIsbn = /(^[0-9]{13}$)/;
            if (!regIsbn.test(isbn)){
                show_validate_msg("#isbn_add_input","error","不合法isbn");
                return false;
            } else {
                $.ajax({
                    url:"${ctp}/checkisbn",
                    data:"isbn="+isbn,
                    type:"POST",
                    success:function (result) {
                        if(result.code==100){
                            show_validate_msg("#isbn_add_input","success","合法ISBN");
                            $("#book_save_btn").attr("ajax-va","success");
                        }else {
                            show_validate_msg("#isbn_add_input","error",result.extend.va_msg);
                            $("#book_save_btn").attr("ajax-va","error");
                        }
                    }
                })
            }
        })

        //模态框中填写的表单数据提交给服务器进行保存
        $("#book_save_btn").click(function () {
            //校验
            if(!validate_add_form()){
                return false;
            }
            //判断之前的ajax校验是否成功
            if($(this).attr("ajax-va")=="error"){
                return false;
            }
            $.ajax({
                url:"${ctp}/book",
                type:"POST",
                data:$("#bookAddModal form").serialize(),
                success:function (result) {
                    if(result.code==100){
                        alert("添加图书成功");
                        $("#bookAddModal").modal('hide');
                        to_page(9999);
                    }else {
                        alert("添加图书失败");
                    }
                }
            })
        })
    })

</script>