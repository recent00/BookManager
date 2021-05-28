<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/24
  Time: 15:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>借还审理</title>
    <%--静态包含 jQuary文件、bootstrap文件--%>
    <%@include file="/pages/common/head.jsp" %>
    <script>
        $(function () {
            $('#header').load("${ctp}/pages/admin/admin_header.jsp");
        })
    </script>
</head>
<body background="${ctp}/static/img/u5.jpeg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<div id="header"></div>
<div class="panel panel-default" style="width: 90%;margin-left: 5%">
    <div class="panel-heading">
        <h3 class="panel-title">
            借还审理
        </h3>
    </div>
    <div class="panel-body">
        <table class="table table-hover" id="audit_table">
            <thead>
            <tr>
                <th>流水号</th>
                <th>图书号</th>
                <th>读者证号</th>
                <th>借出日期</th>
                <th>审核</th>
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
            url: "${ctp}/getAuditLogs",
            data: "pn=" + pn,
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
        $("#audit_table tbody").empty();
        var logs = result.extend.pageInfo.list;
        $.each(logs, function (index, item) {//回调函数，索引，当前对象
            var jsonDate = new Date(parseInt(item.lendDate));
            var newLendDate = jsonDate.format("yyyy-MM-dd");
            var logIdTd = $("<td></td>").append(item.serNum);
            var bookIdTd = $("<td></td>").append(item.bookId);
            var readerIdTd = $("<td></td>").append(item.readerId);
            var lendDateTd = $("<td></td>").append(newLendDate);

            //审核按钮
            var auditBtn = $("<button></button>").addClass("btn btn-success btn-xs audit_btn").append("通过");
            //为通过按钮添加一个自定义的属性，来表示当前记录id
            auditBtn.attr("pass-id", item.serNum);

            //拒绝按钮
            var rejectBtn = $("<button></button>").addClass("btn btn-danger btn-xs reject_btn").append("拒绝");
            rejectBtn.attr("reject-id", item.serNum);

            var btnTd = $("<td></td>").append(auditBtn).append(" ").append(rejectBtn);

            $("<tr></tr>").append(logIdTd)
                .append(bookIdTd)
                .append(readerIdTd)
                .append(lendDateTd)
                .append(btnTd)
                .appendTo("#audit_table tbody");
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

    $(document).on("click", ".audit_btn", function () {
        //确认就发送ajax请求
        $.ajax({
            url: "${ctp}/passLend/" + $(this).attr("pass-id"),
            type: "POST",
            success: function () {
                to_page(currentPage);
            }
        })
    })

    $(document).on("click", ".reject_btn", function () {
        //确认就发送ajax请求
        $.ajax({
            url: "${ctp}/rejectLend/" + $(this).attr("reject-id"),
            type: "POST",
            success: function () {
                to_page(currentPage);
            }
        })
    })

</script>
</body>
</html>
