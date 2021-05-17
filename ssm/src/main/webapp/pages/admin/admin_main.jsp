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
    <%@include file="/pages/common/head.jsp"%>
    <script>
        $(function () {
            $('#header').load("${ctp}/pages/admin/admin_header.jsp");
        })
    </script>
</head>
<body background="${ctp}/static/img/book2.jpg" style=" background-repeat:no-repeat ;background-size:100% 100%;background-attachment: fixed;">

<div id="header"></div>

<div style="padding: 70px 550px 10px">
    <form   method="post" action="" class="form-inline"  id="searchform">
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
                var bookName=$("#search").val();
                if(bookName==''){
                    alert("请输入关键字");
                    return false;
                }else {
                    $.ajax({
                        type:"GET",
                        url:"${ctp}/getBooksByBookName",
                        data:"bookName=" + bookName,
                        success:function (data) {
                            if(data.code==100){
                                //1.解析并显示图书数据
                                build_books_table(data);
                                //2.解析并显示分页信息
                                build_page_info(data);
                                //3.解析并显示分页条
                                build_page_nav(data);
                            }else {
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
    </div>
    <%--显示图书数据--%>
    <div class="panel-body">
        <table class="table table-hover" id="book_table">
            <thead>
            <tr>
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
            url:"${ctp}/getBooks",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
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

    //解析显示员工数据
    function build_books_table(result) {
        //清空table表格
        $("#book_table tbody").empty();
        var books = result.extend.pageInfo.list;
        $.each(books,function (index,item) {//回调函数，索引，当前对象
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
            editBtn.attr("edit-id",item.bookId);

            var delBtn =  $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");

            delBtn.attr("delete_id",item.bookId);

            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            $("<tr></tr>").append(bookIdTd)
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
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页,总"+
            result.extend.pageInfo.pages+"页,总"+
            result.extend.pageInfo.total+"条记录.");
        currentPage = result.extend.pageInfo.pageNum;
    }

    //解析并显示分页条
    function build_page_nav(result) {
        //page_nav_area
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage == false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else {
            //为元素添加点击翻页事件
            firstPageLi.click(function () {
                to_page(1);
            })
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            })
        }
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage == false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else {
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1)
            })

            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }
        //添加首页和前一页 的提示
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi = $("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum == item){
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
</script>
</body>
</html>
