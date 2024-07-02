<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="language" content="en" />
    <meta name="author" content="CTDvic" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <title>CTDvic</title>
    <link rel="shortcut icon" href="IMAGE/c.png" type="image/x-icon">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- jQuery (Bootstrap 的所有 JavaScript 插件都依赖 jQuery，所以必须放在前边) -->
    <script src="js/jquery.js"></script>
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script src="js/bootstrap.min.js"></script>
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/aos.css" rel="stylesheet">
    <link href="css/pattern.css" rel="stylesheet">
    <script src="js/aos.js"></script>
    <!-- datatable插件  -->
    <link href="datatable/dataTables.bootstrap5.min.css" rel="stylesheet">
    <link href="datatable/buttons.bootstrap5.min.css" rel="stylesheet">
    <link href="datatable/jquery.dataTables.min.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="datatable/buttons.bootstrap5.min.js"></script>
    <script type="text/javascript" src="datatable/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="datatable/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="datatable/jszip.min.js"></script>
    <script type="text/javascript" src="datatable/pdfmake.min.js"></script>
    <script type="text/javascript" src="datatable/vfs_fonts.js"></script>
    <script type="text/javascript" src="datatable/buttons.html5.min.js"></script>
    <script type="text/javascript" src="datatable/buttons.print.min.js"></script>
    <!--  自定义   -->
    <link href="css/index.css" rel="stylesheet">
    <link href="css/search-result.css" rel="stylesheet">
    <script src="js/index.js"></script>
    <style>
        .navbar *{
            background-color: transparent;
        }
       .dropdown-menu, .dropdown-menu li a{
font-family: "Gill Sans", sans-serif;
background-color: #599a94;
font-size: 1.3rem;
color: #e8e8e8 ;
font-weight: 600;
}
.dropdown-menu{
border-color: #3E6C6F;
border-width: 1px;
-webkit-transition: all 0.5s ease-in;
-moz-transition: all 0.5s ease-in;
-ms-transition: all 0.5s ease-in;
-o-transition: all 0.5s ease-in;
transition: all 0.5s ease-in;
}
.dropdown-menu a:hover{
color: #3E6C6F !important;
background-color: aliceblue !important;
}
.transp {
background-color:transparent;
transition: background-color 1.5s;
}
.notransp{
background-image: url(IMAGE/non_index.svg);
background-repeat: no-repeat;
background-size: cover;
transition: background-color 1.5s;
}
    </style>
</head>

<body style="margin: 0; overflow-x: hidden;">
<div class="container-fluid">
    <div class="row clearfix">
        <div class="col-md-12 column">
            <!-- nav start  -->
            <div class="row clearfix">
                <div class="col-md-12 column">
                    <nav class="navbar navbar-default navbar-fixed-top" style="background-image:url(IMAGE/non_index.svg);background-repeat: no-repeat;  background-size: cover;border-color:transparent;" id="navigation" role="navigation">
                        <div style="width: 50%; height: 100px; position: absolute;"><a href="index.html"><img src="IMAGE/logo.svg" style="position:relative;width:50%;height:90%; display: inline-block;"></a></div>
                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li>
                                    <a href="index.html">Home</a>
                                </li>
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" style="background-color: transparent !important;">Search<strong class="caret"></strong></a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="search_mo.html">Variant-orient(VL)</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li>
                                            <a href="search_fo_ml.html">Function-orient(VL)</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li>
                                            <a href="search_go.html">Gene-orient(GL)</a>
                                        </li>
                                        <li class="divider"></li>
                                        <li>
                                            <a href="search_fo_gl.html">Function-orient(GL)</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="curation.html"  class="active">Curation</a>
                                </li>
                                <li>
                                    <a href="tools.html">Tools</a>
                                </li>
                                <li>
                                    <a href="jbrowse.html">Genome Browser</a>
                                </li>
                                <li>
                                    <a href="download.html">Download</a>
                                </li>
                                <li>
                                    <a href="submitdata.html">Submit data</a>
                                </li>
                                <li>
                                    <a href="helps.html">Help</a>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>

            <!-- search result_main-->
            <div class="row clearfix shift_down">
                <div class="col-md-12 column">
                    <%
                        //接收disease参数并生成集合,前端参数不能为空
                        String[] disease_type =request.getParameterValues("diseasetype");
                        String disease_ally="'"+disease_type[0]+"'";

                        for(int i=1;i<disease_type.length;i++){
                            disease_ally=disease_ally+",'"+disease_type[i]+"'";
                        }

                        //接收gene参数并生成集合
                        String[] gene=request.getParameterValues("gene");
                        String gene_ally="'"+gene[0]+"'";

                        for(int i=1;i<gene.length;i++){

                            gene_ally=gene_ally+",'"+gene[i]+"'";
                        }

                        //接收element并生成集合
                        String[] element=request.getParameterValues("element");
                        String element_ally="'"+element[0]+"'";

                        for(int i=1;i<element.length;i++){

                            element_ally=element_ally+",'"+element[i]+"'";
                        }

                        //接收region  //生成查询的SQL语句
                        String  search_sql;
                        String chr = request.getParameter("chr");
                        String start_s = request.getParameter("start_position");
                        String end_s = request.getParameter("end_position");
                        if(chr == null || chr.isEmpty() || start_s == null || start_s.isEmpty() || end_s == null || end_s.isEmpty()){
                            search_sql="SELECT * FROM curation where disease in ("+disease_ally+") AND gene in ("+gene_ally+") AND ElementKind in ("+element_ally+")";

                        }
                        else{
                            int start= Integer.valueOf(start_s);
                            int end = Integer.valueOf(end_s);
                            search_sql="SELECT * FROM curation where disease in ("+disease_ally+") AND gene in ("+gene_ally+") AND ElementKind in ("+element_ally+") AND Chromosome = '"+chr+"' AND Hot_Position_Start >= "+start+" AND Hot_Position_End <="+end;
                        }
                    %>

                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            String url = "jdbc:mysql://localhost/ctdna_db"; //数据库名
                            String username = "wyc"; //数据库用户名
                            String password = "112233"; //数据库用户密码
                            Connection conn = DriverManager.getConnection(url, username, password); //连接状态
                    %>
                    <div id="content" class="r-box" data-aos="zoom-in" data-aos-duration="700" style="margin:0;text-align:left;width: 100%">
                        <div class="box_head">
                            <h4 class="pattern-diagonal-stripes-sm text-pattern" data-aos="zoom-in" data-aos-duration="600" data-aos-delay="700">< Curation Search Result ></h4>
                            <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                            <a href="helps.html#help3_3_2"><img id="wenhao" src="IMAGE/wenhao.png"></a>
                        </div>
                        <div>
                            <table id="go_result" class="display" role="grid" aria-describedby="example_info" >
                                <thead>
                                <tr>
                                    <th>Disease</th>
                                    <th>PMID</th>
                                    <th>Gene</th>
                                    <th>Survival</th>
                                    <th>p</th>
                                    <th>nMut</th>
                                    <th>MES.max</th>
                                    <th>maxpos</th>
                                    <th>MES.min</th>
                                    <th>minpos</th>
                                    <th>MES</th>
                                    <th>Chromosome</th>
                                    <th>ElementStart</th>
                                    <th>ElementEnd</th>
                                    <th>ElementLength</th>
                                    <th>FDR</th>
                                    <th>Elementkind</th>
                                    <th>Reference_Genome</th>
                                    <th>Hot_Position_Start</th>
                                    <th>Hot_Position_End</th>
                                    <th>Reference</th>
                                    <th>Alteration</th>
                                    <th>Mutation_type</th>
                                </tr>
                                </thead>
                                <%
                                    Statement stmt = null;
                                    ResultSet rs = null;
                                    String sql = search_sql; //查询语句
                                    stmt = conn.createStatement();
                                    rs = stmt.executeQuery(sql);
                                %>
                                <tbody>
                                <%
                                    //while (rs.next()) {
                                     //   out.print("<tr>");
                                      //  for (int i=1;i<23;i++){
                                       //     if(i==3){
                                       //         out.print("<td>"+rs.getString(i)+"</td>");
                                       //         out.print("<td><a href='survival.jsp?png="+rs.getString(2)+"_sur_"+rs.getString(1)+"_"+rs.getString(3)+"'><img src='IMAGE/sur.png' style='width:50px;height:50px; position:relative; top:-6px'></a></td>");
                                       //     }else {
                                        //        out.print("<td>"+rs.getString(i)+"</td>");
                                        //    }
                                      //  }
                                     //   out.print("</tr>");
                                    //}
                                    while (rs.next()) {
                                        out.println("<tr><td>"+rs.getString(1)+"</td><td> <a href='http://www.ncbi.nlm.nih.gov/pubmed/"
                                                +rs.getString(2)+"' target='_blank'>"+rs.getString(2)+"</a></td><td>"
                                                +rs.getString(3)+"</td><td>"
                                                +"<a href='survival.jsp?png="+rs.getString(2)+"_sur_"+rs.getString(1)+"_"+rs.getString(3)+"'><img src='IMAGE/sur.png' style='width:50px;height:50px; position:relative; top:-6px'></a></td><td>"
                                                +rs.getString(4)+"</td><td>"
                                                +rs.getString(5)+"</td><td>"
                                                +rs.getString(6)+"</td><td>"
                                                +rs.getString(7)+"</td><td>"
                                                +rs.getString(8)+"</td><td>"
                                                +rs.getString(9)+"</td><td>"
                                                +rs.getString(10)+"</td><td>"
                                                +rs.getString(11)+"</td><td>"
                                                +rs.getString(12)+"</td><td>"
                                                +rs.getString(13)+"</td><td>"
                                                +rs.getString(14)+"</td><td>"
                                                +rs.getString(15)+"</td><td>"
                                                +rs.getString(16)+"</td><td>"
                                                +rs.getString(17)+"</td><td>"
                                                +rs.getString(18)+"</td><td>"
                                                +rs.getString(19)+"</td><td>"
                                                +rs.getString(20)+"</td><td>"
                                                +rs.getString(21)+"</td><td>"
                                                +rs.getString(22)+"</td></tr>"

                                        );
                                    }

                                    rs.close();
                                    conn.close();
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <%
                        } catch (Exception e) {
                            e.printStackTrace();
                            out.println("Database connection failure...");
                        }

                    %>

                    <script type="text/javascript">
                        AOS.init({
                            once:true,
                        })
                        $(document).ready(function() {
                            $('#go_result').dataTable({
                                'autoWidth': false,
                                "pagingType": "full_numbers",
                                sortable: false,
                                "scrollX":true,
                                "scrollY":"350px",     //垂直滚动条
                                lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],  //定制长度
                                "pagingType": "full_numbers",  //显示分页所有
                                //stateSave: true   //之前选择的分页
                                dom: 'Bfrtip',
                                "buttons": [
                                    'copyHtml5',
                                    'excelHtml5',
                                    'csvHtml5',
                                ]
                            });
                            //切换显示备注信息，显示部分或者全部

                        });


                    </script>
                </div>
            </div>
            <!-- footer  -->
            <div class="row clearfix shift_down_foot">
                <div class="col-md-12 column" style="margin: 0; padding: 0;">
                    <div class="foot">© College of Bioinformatics Science and Technology, Harbin Medical University, Harbin, China.</div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
</html>