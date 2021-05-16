<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/5/9
  Time: 16:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--得到项目路径,以斜线开始，不以斜线结束--%>
<%
    pageContext.setAttribute("ctp", request.getContextPath());
%>
<!-- Bootstrap -->
<link href="${ctp}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${ctp}/webjars/jquery/3.3.1-2/jquery.min.js"></script>
<script src="${ctp}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
