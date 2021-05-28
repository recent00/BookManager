<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/24
  Time: 19:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>我的借还</title>
    <%--静态包含 jQuary文件、bootstrap文件--%>
    <%@include file="/pages/common/head.jsp" %>
    <script>
        $(function () {
            $('#header').load("${ctp}/pages/reader/reader_header.jsp");
        })
    </script>
</head>
<body background="${ctp}/static/img/u5.jpeg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<div id="header"></div>

<div class="panel panel-default" style="width: 90%;margin-left: 5%;margin-top: 5%">
    <div class="panel-heading">
        <h3 class="panel-title">
            我的借还日志
        </h3>
    </div>
    <div class="panel-body">
        <table class="table table-hover" id="readerLogs_table">
            <thead>
            <tr>
                <th>#</th>
                <th>图书名</th>
                <th>借出日期</th>
                <th>归还日期</th>
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
    <style>
        .panel{
            position: absolute;
            top: 100px;
        }
    </style>
</div>
<script type="text/javascript">
    $(function () {
        to_page(1);
    })

    function to_page(pn) {
        $.ajax({
            url: "${ctp}/getReaderLogs",
            data: {
              pn:pn,
              readerId:${reader.readerId}
            },
            type: "GET",
            success: function (result) {
                //console.log(result);
                //1.解析并显示日志数据
                build_logs_table(result);
                //2.解析并显示分页信息
                build_page_info(result);
                //3.解析并显示分页条
                build_page_nav(result);
            }
        })
    }

    //日期格式转换
    Date.prototype.format = function (format){
        var  o = {
            "y+": this.getFullYear(),
            "M+": this.getMonth()+1,
            "d+": this.getDate(),

        };
        if(/(y+)/.test(format)){
            format = format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));
        }
        for(var k in o){
            if(new RegExp("("+k+")").test(format)){
                format = format.replace(RegExp.$1, RegExp.$1.length == 1?o[k] : ("" + o[k]).substr("" + o[k].length));
            }
        }
        return format;
    };

    //解析显示日志数据
    function build_logs_table(result) {
        //清空table表格
        $("#readerLogs_table tbody").empty();
        var logs = result.extend.pageInfo.list;
        $.each(logs, function (index, item) {//回调函数，索引，当前对象
            var jsonDate = new Date(parseInt(item.lendDate));
            var newLendDate = jsonDate.format("yyyy-MM-dd");
            if(item.backDate != null){
                jsonDate = new Date(parseInt(item.backDate));
                var newBackDate = jsonDate.format("yyyy-MM-dd");
            }
            var logIdTd = $("<td></td>").append(item.serNum);
            var bookIdTd = $("<td></td>").append(item.bookInfo.bookName);
            var lendDateTd = $("<td></td>").append(newLendDate);
            var backDateTd = $("<td></td>").append(newBackDate);

            //归还状态按钮
            if(item.bookStatus == 1){
                var statusBtn = $("<button></button>").addClass("btn btn-defalut btn-xs status_btn disabled").append("待审核");
                statusBtn.attr({"disabled":"disabled"});
            }else if(item.bookStatus == 2){
                var statusBtn = $("<button></button>").addClass("btn btn-success btn-xs status_btn").append("未归还");
            }else if(item.bookStatus == 3){
                var statusBtn = $("<button></button>").addClass("btn btn-defalut btn-xs status_btn disabled").append("未通过");
                statusBtn.attr({"disabled":"disabled"});
            }else {
                var statusBtn = $("<button></button>").addClass("btn btn-success btn-xs status_btn disabled").append("已归还");
                statusBtn.attr({"disabled":"disabled"});
            }

            //为归还按钮添加一个自定义的属性，来表示当前图书id
            statusBtn.attr("return-id", item.serNum);
            var statusBtnTd = $("<td></td>").append(statusBtn);

            //删除按钮
            if(item.bookStatus == 0 || item.bookStatus == 3){
                var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-xs delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            }else {
                var deleteBtn = $("<button></button>").addClass("btn btn-danger btn-xs delete_btn disabled")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                deleteBtn.attr({"disabled":"disabled"});
            }

            //为删除按钮添加一个自定义的属性，来表示当前图书id
            deleteBtn.attr("delete-id", item.serNum);
            var deleteBtnTd = $("<td></td>").append(deleteBtn);

            var btnTd = $("<td></td>").append(statusBtn).append(" ").append(deleteBtn);
            $("<tr></tr>").append(logIdTd)
                .append(bookIdTd)
                .append(lendDateTd)
                .append(backDateTd)
                .append(btnTd)
                .appendTo("#readerLogs_table tbody");
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

   $(document).on("click", ".delete_btn", function () {
        //1.弹出是否确认删除对话框
        if (confirm("确认删除该条记录吗？")) {
            //确认就发送ajax请求
            $.ajax({
                url: "${ctp}/log/" + $(this).attr("delete-id"),
                type: "DELETE",
                success: function () {
                    to_page(currentPage);
                }
            })
        }
    })

    $(document).on("click", ".status_btn", function () {
        //确认就发送ajax请求
        $.ajax({
            url: "${ctp}/returnBook/" + $(this).attr("return-id"),
            type: "POST",
            success: function () {
                to_page(currentPage);
            }
        })
    })


</script>
</body>
</html>
