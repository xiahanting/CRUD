<%--
  Created by IntelliJ IDEA.
  User: xiash
  Date: 2018/6/26
  Time: 22:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<html>
<head>
    <title>员工管理</title>
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">

       //进入页面加载第一页内容和实现下拉列表
        $(function () {

            //加载页面时，显示员工列表第一页信息
            toPage(1);

            //实现部门下拉列表
            $.ajax({
                url: "/deptList",
                type: "post",
                dataType: "json",
                success: function (res) {
                    var $aDept = $("select[name='did']");
                    $.each(res, function (i, dept) {
                        var $opt = $("<option value='" + dept.deptid + "'>" + dept.deptname + "</option>");
                        $aDept.append($opt);
                    })
                }

            });


        });


        //跳转页面
        function toPage(pageNum) {

            $.ajax({
                url: "/empList/" + pageNum,
                type: "post",
                dataType: "json",
                success: function (res) {

                    //显示员工列表
                    var emps = res.pageInfo.list;
                    var $tbody = $("#tbody");
                    $tbody.empty();
                    $.each(emps, function (i, emp) {
                        var $tr = $("<tr></tr>");
                        var $td1 = $("<td><input type='checkbox' name='checkOne' value ='" + emp.empid + "'></td>");
                        var $td2 = $("<td>" + emp.empid + "</td>");
                        var $td3 = $("<td>" + emp.empname + "</td>");
                        var $td4 = $("<td>" + emp.gender + "</td>");
                        var $td5 = $("<td>" + emp.email + "</td>");
                        var $td6 = $("<td>" + emp.department.deptname + "</td>");
                        var $td7 = $("<td> <button type='button' class='btn btn-primary btn-xs' onclick='updateUI(" + emp.empid + ")' data-toggle='modal' data-target='#updateEmpModal'>" +
                            "<span class='glyphicon glyphicon-pencil'></span>编辑 </button>" +
                            " <button type='button' class='btn btn-danger btn-xs' onclick='delEmp(" + emp.empid + ")'>" +
                            " <span class='glyphicon glyphicon-trash'></span>删除 </button> </td>");
                        $tr.append($td1).append($td2).append($td3).append($td4).append($td5).append($td6).append($td7).appendTo($tbody);
                    });


                    //分页功能
                    var pageShow = res.pageInfo;
                    var $nav = $("nav");
                    $nav.empty();
                    var $ul = $("<ul class='pagination'></ul>");
                    var $li1 = $("<li onclick='toPage(1)'><a href='#'>首页</a></li>");
                    var $li2 = $("<li onclick='toPage(" + (pageShow.pageNum - 1) + ")'><a href='#' aria-label='Previous'> <span aria-hidden='true'>&laquo;</span></a>");
                    $ul.append($li1).append($li2);

                    $.each(pageShow.navigatepageNums, function (j, page) {
                        var $li3 = $("<li onclick='toPage(" + page + ")'><a href='#'>" + page + "</a></li>");
                        $ul.append($li3);

                    });
                    var $li4 = $("<li onclick='toPage(" + (pageShow.pageNum + 1) + ")'><a href='#' aria-label='Next'> <span aria-hidden='true'>&raquo;</span></a>");
                    var $li5 = $("<li onclick='toPage(" + (pageShow.pages + 100) + ")'><a href='#'>末页</a></li>");
                    $ul.append($li4).append($li5).appendTo($nav);


                    //页面统计

                    $("#pageSum").text("当前" + pageShow.pageNum + "页，总" + pageShow.pages + "页，总" + pageShow.total + "条记录");

                }
            });
        }

        //新增员工
        function addEmp() {
           //获取表格提交的全部值
            var employee = $("#form1").serialize();

            $.ajax({
                url: "/addEmp",
                type: "post",
                data: employee,

                dataType: "json",
                success: function (res) {
                    alert(res.message);
                    toPage(1);
                }
            });

        }

        //删除员工

        function delEmp(empid) {


            if (confirm("确认删除？")) {
                $.ajax({
                    url: "/delEmp",
                    type: "post",
                    data: {
                        "empid": empid
                    },
                    dataType: "json",
                    success: function (res) {
                        alert(res.message);
                        toPage(1);
                    }
                });
            }


        }

        //批量删除
        function delSel() {

            if (confirm("确认删除这些员工吗？")) {
                var empidNodes = document.getElementsByName("checkOne");
                var empids = [];
                for (var i = 0; i < empidNodes.length; i++) {
                    var empidNode = empidNodes[i];
                    if (empidNode.checked === true) {
                        empids.push(empidNode.value);
                    }
                }
                $.ajax({
                    url: "/delSelEmp",
                    type: "post",
                    data: {
                        "empid": empids
                    },
                    dataType: "json",
                    /*
                      如果不设置 traditional: true,则传递的参数带[],
                      导致SpringMVC 入参接收不到参数
                     */
                    traditional: true,
                    success: function (res) {
                        alert(res.message);
                        toPage(1);
                    }
                });


            }


        }


        //进入修改界面
        function updateUI(empid) {
            $.ajax({
                url: "/updateUI/" + empid,
                type: "post",
                data: {
                    "empid": empid
                },
                dataType: "json",
                success: function (res) {
                    $("#empid2").val(res.empid);
                    $("#empName2").val(res.empname);
                    $("#email2").val(res.email);
                    $("#did2").val(res.did);
                    // $("input[name='gender']").val(res.gender);
                    var $sex1 = $("#sex1");
                    var $sex2 = $("#sex2");

                    if ($sex1.val() === res.gender) {
                        $sex1.prop("checked", true);
                    } else {
                        $sex2.prop("checked", true);
                    }
                }
            });

        }

        //修改员工
        function updateEmp() {

            //获取表格提交的全部值
            var employee = $("#form2").serialize();
            $.ajax({
                url: "/updateEmp",
                type: "post",
                data: employee,
                dataType: "json",
                success: function (res) {
                    alert(res.message);
                    toPage(1);
                }
            });

        }


        //全选/不选功能实现
        function checkAll() {
            var flag = $("input[name='checkAll']")[0].checked;

            //此处如果用attr，而不是prop,那么只有第一次操作生效
            $("input[name='checkOne']").prop("checked", flag);

        }


    </script>


</head>
<body>
<div class="container">

    <%--模态框，最好放在body内--%>


    <!-- Modal，添加员工功能 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="addEmp">增加员工</h4>
                </div>
                <div class="modal-body">
                    <form id="form1" action="##" method="post" onsubmit="return false">
                        <div class="form-group">
                            <label for="empName1">姓名</label>
                            <input type="text" class="form-control" id="empName1" name="empname" placeholder="请输入员工姓名"
                                   required>
                            <span name="checkName" style="color: red"></span>
                        </div>

                        <div class="form-group">
                            <label for="email1">邮箱地址</label>
                            <input type="email" class="form-control" id="email1" name="email" placeholder="请输入邮箱地址"
                                   required>
                        </div>
                        <div class="checkbox">
                            性别： <label>
                            男 <input type="radio" name="gender" value="男" checked>
                        </label>
                            <label>
                                女 <input type="radio" name="gender" value="女">
                            </label>
                        </div>
                        <div class="selected">
                            部门：<select id="did1" name="did">
                        </select>
                        </div>

                        <div class="modal-footer">
                            <button type="button" onclick="addEmp()" class="btn btn-primary" data-dismiss="modal">提交
                            </button>
                            <button type="reset" class="btn btn-default">重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal，员工修改 -->
    <div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                            aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="updateEmp">修改员工!</h4>
                </div>
                <div class="modal-body">
                    <form id="form2" action="##" method="post" onsubmit="return false">
                        <%--员工id，隐藏--%>
                        <input type="hidden" id="empid2" name="empid" >

                        <div class="form-group">
                            <label for="empName2">姓名</label>
                            <input type="text" class="form-control" id="empName2" name="empname" placeholder="请输入员工姓名"
                                   required>
                            <span name="checkName" style="color: red"></span>
                        </div>

                        <div class="form-group">
                            <label for="email2">邮箱地址</label>
                            <input type="email" class="form-control" id="email2" name="email" placeholder="请输入邮箱地址"
                                   required>
                        </div>
                        <div class="checkbox">
                            性别： <label>
                            <input type="radio" id="sex1" name="gender" value="男" checked> 男
                        </label>
                            <label>
                                <input type="radio" id="sex2" name="gender" value="女"> 女
                            </label>
                        </div>
                        <div class="selected">
                            部门：<select id="did2" name="did">

                        </select>
                        </div>


                        <div class="modal-footer">
                            <button type="button" onclick="updateEmp()" class="btn btn-primary" data-dismiss="modal">
                                提交
                            </button>
                            <button type="reset" class="btn btn-default">重置</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-md-3">
            <h3>员工管理</h3>
        </div>
    </div>
    <div class="row">
        <div class="col-md-offset-9">
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">新增</button>
            <button type="button" class="btn btn-danger" onclick="delSel()">批量删除</button>
        </div>
    </div>
    <div class="row">
        <table class="table">
            <tr>
                <th><input type="checkbox" name="checkAll" onclick="checkAll()"><span>全选/不选</span></th>
                <th>编号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>邮箱</th>
                <th>部门</th>
                <th>操作</th>
            </tr>
            <tbody id="tbody">

            </tbody>

        </table>
    </div>
    <div class="row">
        <div class="col-md-3">
            <p id="pageSum"></p>
        </div>
    </div>

    <div class="row">
        <div class="col-md-offset-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">

                </ul>
            </nav>
        </div>
    </div>


</div>

</body>
</html>
