<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/11
  Time: 19:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>管理主页</title>
    <%--静态包含 jQuary文件、bootstrap文件--%>
    <%@include file="/pages/common/head.jsp" %>
    <script>
        $(function () {
            $('#header').load("${ctp}/pages/admin/admin_header.jsp");
        })
    </script>
</head>
<body background="${ctp}/static/img/book2.jpg"
      style=" background-repeat:no-repeat ;background-size:100% 100%;background-attachment: fixed;">

<div id="header"></div>


<%--图书修改模态框--%>
<div class="modal fade" id="bookUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">图书修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="bookName_update_static" class="col-sm-2 control-label">图书名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="bookName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="author_update_static" class="col-sm-2 control-label">作者</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="author_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="publish_update_input" class="col-sm-2 control-label">出版社</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="publish_update_input" placeholder="输入图书出版社"
                                   name="publish">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="isbn_update_static" class="col-sm-2 control-label">ISBN</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="isbn_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="price_update_input" class="col-sm-2 control-label">价格</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="price_update_input" placeholder="输入图书价格"
                                   name="price">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="number_update_input" class="col-sm-2 control-label">剩余数量</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="number_update_input" placeholder="输入图书数量"
                                   name="number">
                            <span class="help-block"></span>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="book_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>


<div style="padding: 70px 550px 10px">
    <form method="post" action="" class="form-inline" id="searchform">
        <div class="input-group">
            <input type="text" placeholder="输入图书名" class="form-control" id="search" name="bookName">
            <span class="input-group-btn">
                <button id="searchBook" type="button" class="btn btn-default">搜索</button>
            </span>
        </div>
    </form>
    <script>
        $(function () {
            $("#searchBook").click(function () {
                var bookName = $("#search").val();
                if (bookName == '') {
                    alert("请输入关键字");
                    return false;
                } else {
                    $.ajax({
                        type: "GET",
                        url: "${ctp}/getBooksByBookName",
                        data: "bookName=" + bookName,
                        success: function (data) {
                            if (data.code == 100) {
                                //1.解析并显示图书数据
                                build_books_table(data);
                                //2.解析并显示分页信息
                                build_page_info(data);
                                //3.解析并显示分页条
                                build_page_nav(data);
                            } else {
                                alert(data.extend.msg);
                            }
                        }
                    })
                }
            })
        })

    </script>
</div>

<div class="panel panel-default" style="width: 90%;margin-left: 5%">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">
            全部图书
        </h3>
        <div class="col-md-offset-11">
            <button class="btn btn-danger" id="book_delete_all_btn">删除</button>
        </div>
    </div>
    <%--显示图书数据--%>
    <div class="panel-body">
        <table class="table table-hover" id="book_table">
            <thead>
            <tr>
                <th>
                    <input type="checkbox" id="check_all"/>
                </th>
                <th>#</th>
                <th>书名</th>
                <th>作者</th>
                <th>出版社</th>
                <th>ISBN</th>
                <th>价格</th>
                <th>剩余数量</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    //1.页面加载完成后，直接去发送一个ajax请求，要到分页数据
    $(function () {
        //去首页
        to_page(1);
    })

    function to_page(pn) {
        $.ajax({
            url: "${ctp}/getBooks",
            data: "pn=" + pn,
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1.解析并显示图书数据
                build_books_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条
                build_page_nav(result);
            }
        })
    }

    //解析显示图书数据
    function build_books_table(result) {
        //清空table表格
        $("#book_table tbody").empty();
        var books = result.extend.pageInfo.list;
        $.each(books, function (index, item) {//回调函数，索引，当前对象
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
            var bookIdTd = $("<td></td>").append(item.bookId);
            var bookNameTd = $("<td></td>").append(item.bookName);
            var bookAuthorTd = $("<td></td>").append(item.author);
            var bookPublicTd = $("<td></td>").append(item.publish);
            var bookIsbnTd = $("<td></td>").append(item.isbn);
            var bookPriceTd = $("<td></td>").append(item.price);
            var bookNumberTd = $("<td></td>").append(item.number);

            //两个操作按钮
            var editBtn = $("<button></button>").addClass("btn btn-info btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

            //为编辑按钮添加一个自定义的属性，来表示当前图书id
            editBtn.attr("edit-id", item.bookId);

            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            delBtn.attr("delete_id", item.bookId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            $("<tr></tr>").append(checkBoxTd)
                .append(bookIdTd)
                .append(bookNameTd)
                .append(bookAuthorTd)
                .append(bookPublicTd)
                .append(bookIsbnTd)
                .append(bookPriceTd)
                .append(bookNumberTd)
                .append(btnTd)
                .appendTo("#book_table tbody");
        })
    }

    var currentPage;

    //解析并显示分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        $("#page_info_area").append("当前" + result.extend.pageInfo.pageNum + "页,总" +
            result.extend.pageInfo.pages + "页,总" +
            result.extend.pageInfo.total + "条记录.");
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析并显示分页条
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.extend.pageInfo.hasPreviousPage == false) {
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为元素添加点击翻页事件
            firstPageLi.click(function () {
                to_page(1);
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            })
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.extend.pageInfo.hasNextPage == false) {
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        } else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1)
            })

            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }
        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        });
        //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    function getBook(id) {
        $.ajax({
            type: "GET",
            url: "${ctp}/book/" + id,
            success: function (result) {
                var bookData = result.extend.book;
                $("#bookName_update_static").text(bookData.bookName);
                $("#author_update_static").text(bookData.author);
                $("#publish_update_input").val(bookData.publish);
                $("#isbn_update_static").text(bookData.isbn);
                $("#price_update_input").val(bookData.price);
                $("#number_update_input").val(bookData.number);
            }
        })
    }

    //点击编辑后发送ajax请求回显表单数据
    $(document).on("click", ".edit_btn", function () {
        //完全清空表单
        reset_form("#bookUpdateModal form");
        //查出员工信息
        getBook($(this).attr("edit-id"));
        //2.把员工id传递给模态框的更新按钮
        $("#book_update_btn").attr("edit-id", $(this).attr("edit-id"));
        //弹出模态框
        $("#bookUpdateModal").modal({
            backdrop: "static"//点击背景不消失
        })
    })
    //更新数据发送给服务器
    $("#book_update_btn").click(function () {
        //验证数据
        var price = $("#price_update_input").val();
        var regPrice = /^[1-9]?\d*(\.\d{1,2})?$/;
        if (!regPrice.test(price)) {
            show_validate_msg("#price_update_input", "error", "输入的价格不合法");
            return false;
        } else {
            show_validate_msg("#price_update_input", "success", "");
        }
        var number = $("#number_update_input").val();
        var regNumber = /(^[0-9]{1,8}$)/;
        if (!regNumber.test(number)) {
            show_validate_msg("#number_update_input", "error", "输入的数量不合法");
            return false;
        } else {
            show_validate_msg("#number_update_input", "success", "");
        }
        //发送ajax请求
        $.ajax({
            type: "PUT",
            url: "${ctp}/book/" + $(this).attr("edit-id"),
            data: $("#bookUpdateModal form").serialize(),
            success: function (result) {
                //关闭模态框
                $("#bookUpdateModal").modal('hide');
                alert(result.extend.msg);
                //回到本页面
                to_page(currentPage);
            }
        })
    })

    //单个删除
    $(document).on("click", ".delete_btn", function () {
        //1.弹出是否确认删除对话框
        var bookName = $(this).parents("tr").find("td:eq(2)").text();
        if (confirm("确认删除【" + bookName + "】吗")) {
            //确认就发送ajax请求
            $.ajax({
                url: "${ctp}/book/" + $(this).attr("delete_id"),
                type: "DELETE",
                success: function (result) {
                    alert(result.extend.msg);
                    to_page(currentPage);
                }
            })
        }
    })

    //完成全选/全不选功能
    $("#check_all").click(function () {
        //attr获取checked是undefined;
        //我们这些dom原生的属性；attr获取自定义属性的值；
        //prop修改和读取dom原生属性的值
        $(".check_item").prop("checked", $(this).prop("checked"));
    })
    //check_item
    $(document).on("click", ".check_item", function () {
        //判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    })
    //点击全部删除
    $("#book_delete_all_btn").click(function () {
        var bookNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            bookNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        })
        //去除bookName多余的,
        bookNames = bookNames.substring(0, bookNames.length - 1);
        //去除del_idstr多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if(confirm("确认删除【"+bookNames+"】吗？")){
            $.ajax({
                type:"DELETE",
                url:"${ctp}/book/"+del_idstr,
                success:function (result) {
                    alert(result.extend.msg);
                    to_page(currentPage);
                }
            })
        }
    })
</script>
</body>
</html>
