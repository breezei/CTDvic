<%--
  Created by IntelliJ IDEA.
  User: win12
  Date: 2023/11/27
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
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
    <!--  自定义   -->
    <link href="css/index.css" rel="stylesheet">
    <link href="css/detail.css" rel="stylesheet">
    <script src="js/index.js"></script>
    <style>
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
                                    <a href="curation.html">Curation</a>
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
                    <div id="content" class="d-box">
                        <div class="box_head">
                            <h4 class="pattern-diagonal-stripes-sm text-pattern" data-aos="flip-left" data-aos="zoom-in" data-aos-duration="600">< Gene Detail ></h4>
                            <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                            <a href="helps.html#help3_2_8"><img id="wenhao" src="IMAGE/wenhao.png"></a>
                        </div>
                        <div class="row clearfix" style="margin-top: 10px">
                            <%
                                String num=request.getParameter("num");
                                String search_sql="select * from gene where number="+num;

                                try {
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    String url = "jdbc:mysql://localhost/ctdna_db"; //数据库名
                                    String username = "wyc"; //数据库用户名
                                    String password = "112233"; //数据库用户密码
                                    Connection conn = DriverManager.getConnection(url, username, password); //连接状态

                                    Statement stmt= null;
                                    ResultSet rs = null;
                                    String sql = search_sql; //查询语句
                                    stmt = conn.createStatement();
                                    rs = stmt.executeQuery(sql);
                                    if(rs.next()){
                            %>
                            <!--        left        -->
                            <div class="col-md-6 col-sm-6 column" style="width: 50%; border-right: dashed 1px #a7c7c2;">
                                <div style="width:96%;">
                                    <table class="table">
                                        <thead class="table-light">
                                        <th colspan="2" style="text-align: left;">Basic information</th>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>Disease</td><td><%= rs.getString(4)%></td>
                                        </tr>
                                        <tr>
                                            <td>Gene</td><td><%= rs.getString(3)%></td>
                                        </tr>
                                        <tr>
                                            <td>Body fluid</td><td><%= rs.getString(5)%></td>
                                        </tr>
                                        <tr>
                                            <td>Pubmed ID</td><td> <a href='http://www.ncbi.nlm.nih.gov/pubmed/<%= rs.getString(2)%>' target='_blank'><%= rs.getString(2)%></a></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                                    <table class="table" >
                                        <thead class="table-light">
                                        <th colspan="2" style="text-align: left;">Experiment</th>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td style="width:25%">Sequence</td><td><%= rs.getString(6)%></td>
                                        </tr>
                                        <tr>
                                            <td>Method</td><td><%= rs.getString(7)%></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                                    <table class="table" style="width:80%">
                                        <thead>
                                        <th colspan="2" style="text-align: left;">Browser view</th>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td><a href="http://genome.ucsc.edu/cgi-bin/hgTracks" target="_blank" style="font-size: 1.5rem;font-weight: 400">UCSC</a></td>
                                            <td><a href="https://www.ensembl.org/Homo_sapiens/Location/View?r=8%3A26291508-26372680;db=core" target="_blank">Emsembl</a></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <!--
                                    <hr class="style2">
                                    <div class="panel-group" id="panel-342315">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <a class="panel-title" data-toggle="collapse" data-parent="#panel-342315" href="#panel-element-638659">Disease-related Gene</a>
                                            </div>
                                            <div id="panel-element-638659" class="panel-collapse in">
                                                <div class="panel-body">
                                                    <table>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><span class="label label-default"><a href="">BRAF</a></span></td>
                                                        <td class="tdl"><a href="">TP53</a></td>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <a class="panel-title collapsed" data-toggle="collapse" data-parent="#panel-342315" href="#panel-element-360424">Disease-related Variant</a>
                                            </div>
                                            <div id="panel-element-360424" class="panel-collapse collapse">
                                                <div class="panel-body">
                                                    <table>
                                                        <td><a href="">T790M</a></td>
                                                        <td><a href="">E545K</a></td>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                     -->
                                </div>
                            </div>
                            <!--   right       -->
                            <div class="col-md-6 col-sm-6 column" style="float:right;width:50%">
                                <table class="table" >
                                    <thead class="table-light">
                                    <th colspan="2" style="text-align: left;">Function</th>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>Drug Resistance</td><td><%= rs.getString(8)%></td>
                                    </tr>
                                    <tr>
                                        <td>Disease Prognosis</td><td><%= rs.getString(9)%></td>
                                    </tr>
                                    <tr>
                                        <td>characteristic Of Tumors</td><td><%= rs.getString(10)%></td>
                                    </tr>
                                    <tr>
                                        <td>Prospects For Detection</td><td><%= rs.getString(11)%></td>
                                    </tr>
                                    <tr>
                                        <td>Metastasis Biomarker</td><td><%= rs.getString(12)%></td>
                                    </tr>
                                    <tr>
                                        <td>Therapy</td><td><%= rs.getString(13)%></td>
                                    </tr>
                                    <tr>
                                        <td>Others</td><td><%= rs.getString(14)%></td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--    bottom      -->
                            <div class="col-md-12 col-sm-12 column">
                                <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                                <table class="table" data-aos="fade-left" data-aos-duration="1000">
                                    <thead class="table-light">
                                    <th colspan="2" style="text-align: center;">External Annotation for <%= rs.getString(3)%> </th>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td style="width: 25%;"><a class="hexIn" href="http://www.genecards.org/cgi-bin/carddisp.pl?gene=<%= rs.getString(3)%>"  target="_blank"> <img src="IMAGE/genecards.png" height="34"/></a></td><td>Information on all annotated and predicted human genes.</td>
                                    </tr>
                                    <tr>
                                        <td><a class="hexIn" href="https://www.ensembl.org/Human/Search/Results?q=<%= rs.getString(3)%>;page=1;facet_feature_type=Gene;facet_species=Human"  target="_blank"> <img src="IMAGE/ensembl.png" height="34"/></a></td><td>Genome browser for vertebrate genomes.</td>
                                    </tr>
                                    <tr>
                                        <td><a class="hexIn" href="https://www.genenames.org/tools/search/#!/?query=<%= rs.getString(3)%>"  target="_blank"> <img src="IMAGE/HGNC.png" height="34"/></a></td><td> Gene nomenclature, gene groups and associated resources including links to genomic, proteomic and phenotypic information.</td>
                                    </tr>
                                    <tr>
                                        <td><a class="hexIn" href="https://www.ncbi.nlm.nih.gov/search/all/?term=<%= rs.getString(3)%>"  target="_blank"> <img src="IMAGE/ncbi.png" height="34"/></a></td><td>An annotated collection of all publicly available DNA sequences.</td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <script>
                                AOS.init({
                                })
                            </script>
                            <%}
                                rs.close();
                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("Database connection failure...");
                            }
                            %>
                        </div>
                    </div>
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

</body>
</html>