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
<%@ page import="java.util.regex.Matcher"%>
<%@ page import="java.util.regex.Pattern"%>
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
    <script src="js/3Dmol.js"></script>
    <script src="js/3Dmol-ui.js"></script>
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
                            <h4 class="pattern-diagonal-stripes-sm text-pattern" data-aos="flip-left" data-aos="zoom-in" data-aos-duration="600" data-aos-delay="700">< Variant Detail ></h4>
                            <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                            <a href="helps.html#help3_2_7"><img id="wenhao" src="IMAGE/wenhao.png"></a>
                        </div>
                        <div class="row clearfix" style="margin-top: 10px">
                                <%
                                    String num=request.getParameter("num");
                                    String search_sql="select * from mutation where number="+num;

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
                                            <td>Disease</td><td><%= rs.getString(6)%></td>
                                        </tr>
                                        <tr>
                                            <td>Gene</td><td><%= rs.getString(3)%></td>
                                        </tr>
                                        <tr>
                                            <td>Mutation type</td><td><%= rs.getString(4)%></td>
                                        </tr>
                                        <tr>
                                            <td>Mutation description</td><td><%= rs.getString(5)%></td>
                                        </tr>
                                        <tr>
                                            <td>Body fluid</td><td><%= rs.getString(7)%></td>
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
                                            <td style="width:25%">Sequence</td><td><%= rs.getString(8)%></td>
                                        </tr>
                                        <tr>
                                            <td>Method</td><td><%= rs.getString(9)%></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                                    <table class="table" >
                                        <thead class="table-light">
                                        <th colspan="2" style="text-align: left;">Function</th>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td>Mechanism</td><td><%= rs.getString(10)%></td>
                                        </tr>
                                        <tr>
                                            <td>Drug resistance</td><td><%= rs.getString(11)%></td>
                                        </tr>
                                        <tr>
                                            <td>Disease prognosis</td><td><%= rs.getString(12)%></td>
                                        </tr>
                                        <tr>
                                            <td style="width:25%;">Tumors characteristic</td><td><%= rs.getString(13)%></td>
                                        </tr>
                                        <tr>
                                            <td>Prospects for detection</td><td><%= rs.getString(14)%></td>
                                        </tr>
                                        <tr>
                                            <td>Metastasis biomarker</td><td><%= rs.getString(15)%></td>
                                        </tr>
                                        <tr>
                                            <td>Therapy</td><td><%= rs.getString(16)%></td>
                                        </tr>
                                        <tr>
                                            <td>Others</td><td><%= rs.getString(17)%></td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <!--   right       -->
                                <% //查询transvar表
                                    String gene = rs.getString(3);
                                    String mutation = rs.getString(5);
                                    String search_sql2 = "select * from transvar where gene='"+gene+"' AND `variant description`='" + mutation+"'";
                                    String sql2 = search_sql2;
                                    Statement stmt2= null;
                                    ResultSet rs2= null;
                                    stmt2 = conn.createStatement();
                                    rs2 = stmt2.executeQuery(sql2);
                                    if(rs2.next()) {
                                %>
                            <div class="col-md-6 col-sm-6 column" style="float:right;width:50%">
                                <table class="table table-bordered">
                                    <thead>
                                    <th colspan="2" style="text-align: left;">Variant Site</th>
                                    </thead>
                                    <tbody>
                                    <tr>
                                        <td>Strand(+/-)</td>
                                        <td><%=rs2.getString(3)%></td>
                                    </tr>
                                    <tr>
                                        <td>gDNA</td>
                                        <td><%=rs2.getString(4)%></td>
                                    </tr>
                                    <tr>
                                        <td>cDNA</td>
                                        <td><%=rs2.getString(5)%></td>
                                    </tr>
                                    <tr>
                                        <td>Protein</td>
                                        <td><%=rs2.getString(6)%></td>
                                    </tr>
                                    <tr>
                                        <td>Source Database</td>
                                        <td>refSeq</td>
                                    </tr>
                                    <tr>
                                        <td>Genome Build</td>
                                        <td>GRch38/hg38</td>
                                    </tr>
                                    <tr>
                                        <td>Sequence</td>
                                        <td><%=rs2.getString(7)%></td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                                <table class="table" style="width:80%">
                                    <thead>
                                    <th colspan="2" style="text-align: left;">Browser view</th>
                                    </thead>
                                    <tbody>
                                    <%
                                        String str1 = ".";
                                        String coordinate = rs2.getString(4);
                                        if (!str1.equals(coordinate)) {
                                            // 字符串匹配
                                            // 提取 ":" 前的部分
                                            int colonIndex = coordinate.indexOf(":");
                                            String beforeColon = coordinate.substring(0, colonIndex);

                                            // 提取 ":" 后的数字部分
                                            String afterColon = coordinate.substring(colonIndex + 1);
                                            // 使用正则表达式提取数字部分
                                            Pattern pattern = Pattern.compile("\\d+");
                                            Matcher matcher = pattern.matcher(afterColon);
                                            // 查找匹配的数字
                                            // 尝试查找匹配的内容
                                            String nb;
                                            String genome_coor;
                                            if (matcher.find()) {
                                                // 找到匹配的内容
                                                nb = matcher.group();
                                                // 使用 parseInt 方法将字符串转为整数
                                                int intValue = Integer.parseInt(nb);
                                                int star_g = intValue - 10000;
                                                int end_g = intValue + 10000;
                                                genome_coor = beforeColon + ":" + star_g +"-"+end_g;
                                                out.println(" <tr>\n" +
                                                        "                                        <td><a href=\"http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&lastVirtModeType=default&lastVirtModeExtraState=&virtModeType=default&virtMode=0&nonVirtPosition=&position="+genome_coor+"&hgsid=1883970034_pKL5mmLJCw4zeS3j6ZgyHYBtlAga\" target=\"_blank\"  style=\"font-size: 1.5rem;font-weight: 400\">UCSC</a></td>\n" +
                                                        "                                        <td><a href=\"https://useast.ensembl.org/Homo_sapiens/Location/View?r="+genome_coor+";db=core\" target=\"_blank\">Emsembl</a></td>\n" +
                                                        "                                    </tr>");
                                            }
                                            else {
                                                // 没有找到匹配的内容
                                                out.println(" <tr>\n" +
                                                        "                                        <td><a href=\"http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&lastVirtModeType=default&lastVirtModeExtraState=&virtModeType=default&virtMode=0&nonVirtPosition=&position=chr15:66425116-66445116&hgsid=1883970034_pKL5mmLJCw4zeS3j6ZgyHYBtlAga\" target=\"_blank\"  style=\"font-size: 1.5rem;font-weight: 400\">UCSC</a></td>\n" +
                                                        "                                        <td><a href=\"https://useast.ensembl.org/Homo_sapiens/Location/View?r=15:66425116-66445116;db=core\" target=\"_blank\">Emsembl</a></td>\n" +
                                                        "                                    </tr>");
                                            }
                                            %>
                                        </tbody>
                                    </table>
                                    <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                                    <div class="tabbable" id="tabs-701263">
                                        <ul class="nav nav-tabs">
                                            <li class="active">
                                                <a href="#panel-937536" data-toggle="tab" style="background-color: rgba(244,244,242,0.8)">Non-Variant</a>
                                            </li>
                                            <li>
                                                <a href="#panel-275247" data-toggle="tab" style="background-color: rgba(244,244,242,0.8)">Variant</a>
                                            </li>
                                        </ul>
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="panel-937536" style="overflow: hidden;"><!-- class='viewer_3Dmoljs' data-url="protein/PDB/PDB_novariant/" data-backgroundcolor='0xffffff' data-style='cartoon:color=spectrum' data-ui='true'  -->
                                                <div style="position: relative;left: -50px; background-color: white; height: 400px; width: 400px; border: #184e77 2px solid;margin: 10px 10px;box-shadow: 2px 2px 2px #8c8b8b;display: inline-block ">
                                                    <!-- molViewer div的属性在下方div重置 -->
                                                    <div id="molViewer" class="viewer_3Dmoljs" style="height: 380px; width: 380px; margin: 10px 10px;position: relative; visibility: hidden;" data-url=" http://localhost:8082/protein/PDB/PDB_novariant/<%=gene + ".pdb"%>" data-backgroundcolor='0xffffff' data-style='cartoon:color=spectrum' data-ui='true'>
                                                    </div>
                                                </div>
                                                <script> var gene="<%=gene%>"</script>
                                                <a href="protein/PDB/PDB_novariant/<%=gene + ".pdb"%>" download>
                                                    <button class="download_button" type="button" style="position: absolute">
                                                        <span class="button__text">.PDB</span>
                                                        <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                                    </button>
                                                </a>
                                            </div>
                                            <div class="tab-pane" id="panel-275247">
                                                <div style="display: inline-block;width: 80%;margin: 20px 0 0 0;float: left; border: #184e77 2px dotted;box-shadow: 2px 2px 2px #8c8b8b">
                                                    <img src="protein/png/3Dstructure_variant/<%=gene + "_" + mutation + ".png"%>">
                                                </div>
                                                <div style="display: inline-block; width: 20%;margin-top: 10px">
                                                    <a href="protein/png/3Dstructure_variant/<%=gene + "_" + mutation + ".png"%>" download>
                                                        <button class="download_button" type="button" style="margin: 10px 0px">
                                                            <span class="button__text">.PNG</span>
                                                            <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                                        </button>
                                                    </a>
                                                    <br>
                                                    <a href="protein/PDB/PDB_variant/<%=gene + "_" + mutation + ".pdb"%>" download>
                                                        <button class="download_button" type="button" style="margin: 10px 0px">
                                                            <span class="button__text">.PDB</span>
                                                            <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                                        </button>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                    <%
                                        }else { //判断是否为"."，为否时
                                                out.println(" <tr>\n" +
                                                        "                                        <td><a href=\"http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38&lastVirtModeType=default&lastVirtModeExtraState=&virtModeType=default&virtMode=0&nonVirtPosition=&position=chr15:66425116-66445116&hgsid=1883970034_pKL5mmLJCw4zeS3j6ZgyHYBtlAga\" target=\"_blank\"  style=\"font-size: 1.5rem;font-weight: 400\">UCSC</a></td>\n" +
                                                        "                                        <td><a href=\"https://useast.ensembl.org/Homo_sapiens/Location/View?r=15:66425116-66445116;db=core\" target=\"_blank\">Emsembl</a></td>\n" +
                                                        "                                    </tr>");

                                    //transvar能查到，但是为"."%>
                            </tbody>
                            </table>
                            <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                            <div class="tabbable" id="tabs-701265">
                                <ul class="nav nav-tabs">
                                    <li class="active">
                                        <a href="#panel-937538" data-toggle="tab" style="background-color: rgba(244,244,242,0.8)">Non-Variant</a>
                                    </li>
                                    <li>
                                        <a href="#panel-275249" data-toggle="tab" style="background-color: rgba(244,244,242,0.8)">Variant</a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="panel-937538" style="overflow: hidden;"><!-- class='viewer_3Dmoljs' data-url="protein/PDB/PDB_novariant/" data-backgroundcolor='0xffffff' data-style='cartoon:color=spectrum' data-ui='true'  -->
                                        <div style="position: relative;left: -50px; background-color: white; height: 400px; width: 400px; border: #184e77 2px solid;margin: 10px 10px;box-shadow: 2px 2px 2px #8c8b8b;display: inline-block ">
                                            <!-- molViewer div的属性在下方div重置 -->
                                            <div id="molViewer" class="viewer_3Dmoljs" style="height: 380px; width: 380px; margin: 10px 10px;position: relative; visibility: hidden;" data-url=" http://localhost:8082/protein/PDB/PDB_novariant/<%=gene + ".pdb"%>" data-backgroundcolor='0xffffff' data-style='cartoon:color=spectrum' data-ui='true'>
                                            </div>
                                        </div>
                                        <script> var gene="<%=gene%>"</script>
                                        <a href="protein/PDB/PDB_novariant/<%=gene + ".pdb"%>" download>
                                            <button class="download_button" type="button" style="position: absolute">
                                                <span class="button__text">.PDB</span>
                                                <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                            </button>
                                        </a>
                                    </div>
                                    <div class="tab-pane" id="panel-275249">
                                        <div style="display: inline-block;width: 80%;margin: 20px 0 0 0;float: left; border: #184e77 2px dotted;box-shadow: 2px 2px 2px #8c8b8b">
                                            <img src="protein/png/3Dstructure_variant/<%=gene + "_" + mutation + ".png"%>">
                                        </div>
                                        <div style="display: inline-block; width: 20%;margin-top: 10px">
                                            <a href="protein/png/3Dstructure_variant/<%=gene + "_" + mutation + ".png"%>" download>
                                                <button class="download_button" type="button" style="margin: 10px 0px">
                                                    <span class="button__text">.PNG</span>
                                                    <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                                </button>
                                            </a>
                                            <br>
                                            <a href="protein/PDB/PDB_variant/<%=gene + "_" + mutation + ".pdb"%>" download>
                                                <button class="download_button" type="button" style="margin: 10px 0px">
                                                    <span class="button__text">.PDB</span>
                                                    <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                                </button>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                                <% } //判断是否为"."，否的反括号

                                    }else{ //if(rs2)反括号及RS2查询结果为空时执行起始 %>
                            <div class="col-md-6 col-sm-6 column" style="float:right;width:50%">
                                <table class="table table-bordered">
                                    <thead>
                                    <th colspan="2" style="text-align: left;">Variant Site</th>
                                    </thead>
                                    <tbody>
                                        <td>
                                            <div style="height: 38px; text-align: center; margin-top: 6px; font-weight: 500; font-size: 14px;"> Data is null...</div>
                                        </td>
                                    </tbody>
                                </table>
                                <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                                <table class="table" style="width:80%">
                                    <thead>
                                    <th colspan="2" style="text-align: left;">Browser view</th>
                                    </thead>
                                    <tbody>
                                    <td><a href = "http://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38" target="_blank"  style="font-size: 1.5rem;font-weight: 400">UCSC</a></td>
                                    <td><a href = "https://asia.ensembl.org/Homo_sapiens/Location/View?db=core;r=15:66425116-66445116" target="_blank">Emsembl</a></td>
                                    </tbody>
                                </table>
                                <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                                <div class="tabbable" id="tabs-701264">
                                    <ul class="nav nav-tabs">
                                        <li class="active">
                                            <a href="#panel-937531" data-toggle="tab" style="background-color: rgba(244,244,242,0.8)">Non-Variant</a>
                                        </li>
                                        <li>
                                            <a href="#panel-275241" data-toggle="tab" style="background-color: rgba(244,244,242,0.8)">Variant</a>
                                        </li>
                                    </ul>
                                    <div class="tab-content">
                                        <div class="tab-pane active" id="panel-937531" style="overflow: hidden;"><!-- class='viewer_3Dmoljs' data-url="protein/PDB/PDB_novariant/" data-backgroundcolor='0xffffff' data-style='cartoon:color=spectrum' data-ui='true'  -->
                                            <div style="position: relative;left: -50px; background-color: white; height: 400px; width: 400px; border: #184e77 2px solid;margin: 10px 10px;box-shadow: 2px 2px 2px #8c8b8b;display: inline-block ">
                                                <!-- molViewer div的属性在下方div重置 -->
                                                <div id="molViewer" class="viewer_3Dmoljs" style="height: 380px; width: 380px; margin: 10px 10px;position: relative; visibility: hidden;" data-url=" http://localhost:8082/protein/PDB/PDB_novariant/<%=gene + ".pdb"%>" data-backgroundcolor='0xffffff' data-style='cartoon:color=spectrum' data-ui='true'>
                                                </div>
                                            </div>
                                            <script> var gene="<%=gene%>"</script>
                                            <a href="protein/PDB/PDB_novariant/<%=gene + ".pdb"%>" download>
                                                <button class="download_button" type="button" style="position: absolute">
                                                    <span class="button__text">.PDB</span>
                                                    <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                                </button>
                                            </a>
                                        </div>
                                        <div class="tab-pane" id="panel-275241">
                                            <div style="display: inline-block;width: 80%;margin: 20px 0 0 0;float: left; border: #184e77 2px dotted;box-shadow: 2px 2px 2px #8c8b8b">
                                                <img src="protein/png/3Dstructure_variant/<%=gene + "_" + mutation + ".png"%>">
                                            </div>
                                            <div style="display: inline-block; width: 20%;margin-top: 10px">
                                                <a href="protein/png/3Dstructure_variant/<%=gene + "_" + mutation + ".png"%>" download>
                                                    <button class="download_button" type="button" style="margin: 10px 0px">
                                                        <span class="button__text">.PNG</span>
                                                        <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                                    </button>
                                                </a>
                                                <br>
                                                <a href="protein/PDB/PDB_variant/<%=gene + "_" + mutation + ".pdb"%>" download>
                                                    <button class="download_button" type="button" style="margin: 10px 0px">
                                                        <span class="button__text">.PDB</span>
                                                        <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                                    </button>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% }
                                    rs2.close();
                                %>
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

                                <table class="table"  data-aos="fade-right" data-aos-duration="1000">
                                    <thead class="table-light">
                                        <th colspan="2" style="text-align: center;">External Annotation for mutation <%= rs.getString(5)%> </th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td style="width: 25%;"><a class="hexIn" href="https://civicdb.org/variants/home"  target="_blank"> <img src="IMAGE/civic.png" height="34"/></a></td><td>The clinical relevance explanation of variants to cancer at the histological level.</td>
                                        </tr>
                                        <tr>
                                            <td><a class="hexIn" href="https://cancer.sanger.ac.uk/cosmic/search?q=<%= rs.getString(3)%>+<%= rs.getString(5)%>"  target="_blank"> <img src="IMAGE/cosmic.png" height="34"/></a></td><td>The catalogue of somatic mutations in cancer.</td>
                                        </tr>
                                        <tr>
                                            <td><a class="hexIn" href="https://ckb.jax.org/geneVariant/find"  target="_blank"> <img src="IMAGE/ckb.png" height="34"/></a></td><td>Including gene/variant annotations, therapy knowledge, diagnostic/prognostic information, and clinical trials related to oncology. </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <script>
                                AOS.init({
                                })
                                //解决3dmol和AOS冲突
                                setTimeout(function() {
                                    let element = document.getElementById('molViewer');
                                    element.style.visibility = "visible";
                                    let config = { backgroundColor: 'white' };
                                    let viewer = $3Dmol.createViewer( element, config );
                                    let pdbUri = "protein/PDB/PDB_novariant/"+gene+".pdb";
                                    jQuery.ajax( pdbUri, {
                                        success: function(data) {
                                            let v = viewer;
                                            v.addModel( data, "pdb" );                       /* load data */
                                            v.setStyle({}, {cartoon: {color: 'spectrum'}});  /* style all atoms */
                                            v.zoomTo();                                      /* set camera */
                                            v.render();                                      /* render scene */
                                            v.zoom(1.5, 1000);                               /* slight zoom */

                                        },
                                        error: function(hdr, status, err) {
                                            console.error( "Failed to load PDB " + pdbUri + ": " + err );
                                        },
                                    });
                                }, 2000);
                            </script>
                                    <%}//if(rs1)的反括号
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