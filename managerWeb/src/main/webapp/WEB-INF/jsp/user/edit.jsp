<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>用户信息编辑界面</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <%@include file="/WEB-INF/jsp/common/common.jsp"%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/dist/css/skins/_all-skins.min.css">
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<!-- Site wrapper -->
<div class="wrapper">
    <!-- ===============顶部================================ -->
    <%@include file="/WEB-INF/jsp/common/top.jsp"%>

    <!-- Left side column. contains the sidebar 左侧边栏-->
    <%@include file="/WEB-INF/jsp/common/leftSide.jsp"%>

    <!-- =============================================== -->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Blank page
                <small>it all starts here</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
                <li><a href="#">Examples</a></li>
                <li class="active">Blank page</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <!-- Default box -->
            <div class="row">
                <!-- right column -->
                <div class="col-md-12">
                    <div class="box">
                        <!-- form start    put:/users/1 -->
                        <form:form cssClass="form-horizontal" action="${pageContext.request.contextPath}/users/${user.id}" method="post" modelAttribute="user">
                        <%--<form class="form-horizontal" action="${pageContext.request.contextPath}/users" method="post">--%>
                            <input type="hidden" name="_method" value="put"/>
                            <form:hidden path="id"></form:hidden>
                            <div class="box-body">

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="name" class="col-sm-2 control-label">名称</label>
                                        <div class="col-sm-10">
                                            <form:input path="name" cssClass="form-control"  placeholder="名称"></form:input>
                                            <%--<input type="text" id="name" name="name" class="form-control" placeholder="名称"/>--%>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="header" class="col-sm-2 control-label">头像</label>
                                        <div class="col-sm-10">
                                            <form:input path="header" cssClass="form-control"  placeholder="头像"></form:input>
                                            <%--<input type="text" id="header" name="header"  class="form-control" placeholder="头像"/>--%>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="loginName" class="col-sm-2 control-label">账号</label>
                                        <div class="col-sm-10">
                                            <form:input path="loginName" readonly="true" cssClass="form-control"  placeholder="账号"/>
                                            <%--<input type="text" id="loginName" name="loginName" class="form-control" placeholder="账号"/>--%>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="box-footer">
                                <button type="reset" class="btn btn-default btn-flat">重 置</button>
                                <button type="submit" class="btn btn-success btn-flat">更新</button>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!--底部-->
    <%@include file="/WEB-INF/jsp/common/foot.jsp"%>

    <!-- Control Sidebar右侧边栏 -->
    <%@include file="/WEB-INF/jsp/common/setting.jsp"%>
    <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- SlimScroll -->
<script src="${pageContext.request.contextPath}/static/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath}/static/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/static/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath}/static/dist/js/demo.js"></script>
<script>
    $(document).ready(function () {
        $('.sidebar-menu').tree();

    });
</script>
</body>
</html>

