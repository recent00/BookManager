<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/11
  Time: 19:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>读者主页</title>
    <%--静态包含 jQuary文件、bootstrap文件--%>
    <%@include file="/pages/common/head.jsp"%>
    <script>
        $(function () {
            $('#header').load('${ctp}/pages/reader/reader_header.jsp');
        })
    </script>
</head>
<body background="${ctp}/static/img/book3.jpg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<div id="header"></div>
</body>
</html>
