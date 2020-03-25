<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2020/3/7
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>影院管理系统首页</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <%@include file="/WEB-INF/jsp/common/common.jsp"%>
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/dist/css/skins/_all-skins.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Google Font -->
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
            <div class="box">

                <div class="box-body">
                    <div class="row">
                        <form id="searchForm" action="" onsubmit="return false;">

                            <div class="col-xs-2">
                                <select class="form-control" name="name">
                                    <option value="">请选组</option>
                                    <option value="name">姓名</option>
                                    <option value="loginName">账号</option>
                                </select>
                            </div>

                            <div class="col-xs-2">
                                <input type="text" name="keyWords" class="form-control" placeholder="关键字">
                            </div>
                            <div class="col-xs-2">
                                <button type="submit" class="btn bg-olive btn-flat">查询</button>
                            </div>
                        </form>
                    </div>
                    <div id="toolbar">
                        <a href="${pageContext.request.contextPath}/users/addUI" type="button" class="btn bg-maroon btn-flat">添加</a>
                        <button type="button" data-ope="delete" class="btn bg-olive btn-flat">删除</button>
                        <button type="button" data-ope="edit" class="btn bg-orange btn-flat">编辑</button>
                    </div>
                    <table id="table_user"></table>
                </div>
                <!-- /.box-body -->
            </div>
            <!-- /.box -->

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->

    <!--底部-->
    <%@include file="/WEB-INF/jsp/common/foot.jsp"%>

    <!-- Control Sidebar右侧边栏 -->
    <%@include file="/WEB-INF/jsp/common/setting.jsp"%>
    <!-- /.control-sidebar -->
    <!-- Add the sidebar's background. This div must be placed
         immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!--引入bootstrap-table资源文件-->
<script src="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table.js"></script>
<script src="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/bower_components/table/bootstrap-table.css">

<!-- SlimScroll -->
<script src="${pageContext.request.contextPath}/static/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath}/static/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="${pageContext.request.contextPath}/static/dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="${pageContext.request.contextPath}/static/dist/js/demo.js"></script>
<script>
 /*   {"result":true,"msg":"查询成功","count":1,"data":[{"id":1,"name":"zs","loginName":"zs","password":"123","status":1,"header":"head.jpg"}]}*/
    $(document).ready(function () {
        $('.sidebar-menu').tree();

        $("form[id=searchForm]").on("submit",function(){
            var $it = $(this);
            var conditionName = $it.find("select[name='name']").val();
            if(conditionName){
                var conditionValue = $it.find("input[name='keyWords']").val();
                if(conditionValue){
                    //拼接查询条件
                    var requestParam = {};
                    requestParam[conditionName]=conditionValue;
                    //刷新table插件
                    console.log(requestParam);
                    $table.bootstrapTable('refresh',{query:requestParam});
                }else{
                    $table.bootstrapTable('refresh');
                }
            }else{
                $table.bootstrapTable('refresh');
            }
            return false;
        });


        $("#toolbar > button").on("click",function(){
           var $it = $(this);
           var ope = $it.data("ope");
           if("delete"==ope){
               //获取选中的数据（id）
               var idArray = $table.bootstrapTable('getAllSelections');
               idArray = $.map(idArray,function(item){
                    return item.id;
               });
               /*[1,2,3] to "1,2,3"*/
               var ids = idArray.join(",");
               $.ajax({
                   /*restful风格：/users/1,2,3*/
                   url:"${pageContext.request.contextPath}/users/"+ids,
                   type:"post",
                   data:"_method=delete",
                   success:function(data){
                       if(data.result){
                            $table.bootstrapTable("refresh");
                       }else{
                           alert(data.msg);
                       }
                   }
               })


           }else if("edit"==ope){
               //获取选中的数据（id）
               var idArray = $table.bootstrapTable('getAllSelections');
               if(idArray.length==1){
                    var id = idArray[0].id;
                    window.location.href=request.contextPath+"/users/"+id+"/edit";
               }else{
                   alert("有且只能选中一条");
               }
           }

        });
        $table = $('#table_user').bootstrapTable({
            url: '${pageContext.request.contextPath}/users',  //数据来源[ajax]--->
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: true,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber:1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            smartDisplay:false,
            search: false,                      //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
            strictSearch: true,
            showColumns: false,                 //是否显示所有的列
            showRefresh: false,                 //是否显示刷新按钮
            minimumCountColumns: 2,             //最少允许的列数
            clickToSelect: true,                //是否启用点击选中行
            uniqueId: "id",                     //每一行的唯一标识，一般为主键列
            showToggle:false,                   //是否显示详细视图和列表视图的切换按钮
            cardView: false,                    //是否显示详细视图
            detailView: false,                   //是否显示父子表
            queryParams : function (params) {  //params:查询参数
                params.pageSize=params.limit;
                params.page = (params.offset/params.pageSize)+1;
                delete params.limit;
                delete params.offset;
                /*  private Integer page=1;    //当前第几页
                  private Integer pageSize=10; //每页显示多少条
                  */
                return params;
            },
            columns: [{
                checkbox: true
            },{
                field: 'name',
                title: '昵称'
            },{
                field: 'loginName',
                title: '账号'
            },{
                field: 'status',
                title: '状态',
                formatter: statusFormatter
            }],
            responseHandler: function(res) {
                //获取到服务响应回来的数据，先经过这里
                return {
                    "total": res.count,//总的记录数
                    "rows": res.data   //数据
                };
            }
        });
    });
    //0:未激活 1:已激活  2:已删除
    function statusFormatter(value, row, index){
        if("1"==value){
            return "已激活";
        }else if("0"==value){
            return "未激活";
        }else{
            return "已删除";
        }
    }
</script>
</body>
</html>

