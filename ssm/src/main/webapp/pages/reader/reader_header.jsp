<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/pages/common/head.jsp"%>
<nav class="navbar navbar-default" role="navigation" style="background-color:#fff">
    <div class="container-fluid">
        <div class="navbar-header" style="margin-left: 8%;margin-right: 1%">
            <a class="navbar-brand " href="${ctp}/pages/reader/reader_main.jsp"><p class="text-primary" style="font-family: 华文行楷; font-size: 200%; ">我的图书馆</p></a>
        </div>
        <div class="collapse navbar-collapse" id="example-navbar-collapse">
            <ul class="nav navbar-nav navbar-left">
                <li class="active">
                    <a href="${ctp}/pages/reader/reader_main.jsp">
                        图书查询
                    </a>
                </li>
                <li>
                    <a href="${ctp}/pages/reader/reader_info.jsp" >
                        个人信息
                    </a>
                </li>
                <li >
                    <a href="${ctp}/pages/reader/reader_lend_list.jsp" >
                        我的借还
                    </a>
                </li>
                <li >
                    <a href="${ctp}/pages/reader/reader_repwd.jsp" >
                        密码修改
                    </a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="reader_info.html">${reader.readerName}, 已登录</a></li>
                <li><a href="${ctp}/logout">退出</a></li>
            </ul>
        </div>
    </div>
</nav>
