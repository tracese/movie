<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2020/3/6
  Time: 13:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录界面</title>
    <%@include file="/WEB-INF/jsp/common/common.jsp"%>

    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

</head>
<body class="hold-transition login-page">
<div class="login-box">
    <div class="login-logo">
        <a href="#"><b>影院后台管理系统</b></a>
    </div>
    <!-- /.login-logo -->
    <div class="login-box-body">
        <p class="login-box-msg" style="font-size:larger;font-weight: bolder">用户登录界面</p>
        <%
            Cookie[] cookies = request.getCookies();
            String loginName = null;
            String password = null;
            for(Cookie cookie:cookies){
                if("loginName".equals(cookie.getName())){
                    loginName = cookie.getValue();
                }else if("password".equals(password)){
                    password = cookie.getValue();
                }
            }
            request.setAttribute("loginName",loginName);
            request.setAttribute("password",password);
        %>
        <form id="form_event" method="post">
            <div class="form-group has-feedback">
                <input type="type" name="loginName" value="${loginName==null?"root":loginName}" class="form-control" placeholder="账号/手机号/邮箱">
                <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="form-group has-feedback">
                <input type="password" name="password" value="${password==null?"123":password}" class="form-control" placeholder="密码">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>
                            <input type="checkbox" value="1" name="remember"> 记住我
                        </label>
                    </div>
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <button type="submit" class="btn btn-primary btn-block btn-flat">登录</button>
                </div>
                <!-- /.col -->
            </div>
        </form>
    </div>
    <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
<!-- iCheck -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/dist/plugins/iCheck/square/blue.css">

<!-- iCheck -->
<script src="${pageContext.request.contextPath}/static/dist/plugins/iCheck/icheck.min.js"></script>
<%--Validator--%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/dist/plugins/validate/css/bootstrapValidator.min.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/dist/plugins/validate/js/bootstrapValidator.min.js"></script>

<script>
    $(function () {
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' /* optional */
        });
    });
    $(document).ready(function() {
        $('#form_event')
            .bootstrapValidator({
                message: 'This value is not valid',
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    loginName: {
                        message: '账号无效',
                        validators: {
                            notEmpty: {
                                message: '账号不能为空'
                            },
                        }
                    },
                    password: {
                        validators: {
                            notEmpty: {
                                message: '密码不能为空'
                            }
                        }
                    }
                }
            })
            .on('success.form.bv', function(e) {
                // Prevent form submission
                e.preventDefault();

                // Get the form instance
                var $form = $(e.target);

                // Use Ajax to submit form data
                var loginName = $form.find("input[name=loginName]").val();
                var password = $form.find("input[name=password]").val();
                var remember = $form.find("input[name=remember]").val();
                //发送ajax
                $.ajax({
                    url:"${pageContext.request.contextPath}/login",
                    type:"post",
                    data:"loginName="+loginName+"&password="+password+"&remember="+remember,
                    success:function(data){
                        if(data.result){
                            window.location.href="${pageContext.request.contextPath}/main";
                        }else{
                            alert(data.msg);
                        }
                    }
                })
            });
    });

</script>

</body>
</html>
