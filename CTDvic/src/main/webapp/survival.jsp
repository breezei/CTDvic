<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
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
    <link rel="stylesheet" href="css/nice-select.css">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/aos.css" rel="stylesheet">
    <link href="css/pattern.css" rel="stylesheet">
    <script src="js/aos.js"></script>
    <!--  自定义   -->
    <link href="css/index.css" rel="stylesheet">
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
        <!-- button -->
       .example_button {
           position: relative;
           width: 150px;
           height: 40px;
           cursor: pointer;
           display: inline-flex;
           align-items: center;
           border: 1px solid #0E1822;
           background-color: #184e77;
           overflow: hidden;
           margin-right: 10px;
       }

       .example_button, .button__icon, .button__text {
           transition: all 0.3s;
       }

       .example_button .button__text {
           transform: translateX(22px);
           color: #fff;
           font-weight: 600;
       }

       .example_button .button__icon {
           position: absolute;
           transform: translateX(109px);
           height: 100%;
           width: 39px;
           background-color: #0E1822;
           display: flex;
           align-items: center;
           justify-content: center;
       }

       .example_button .svg {
           width: 20px;
           fill: #fff;
       }

       .example_button:hover {
           background: #0E1822;
       }

       .example_button:hover .button__text {
           color: transparent;
       }

       .example_button:hover .button__icon {
           width: 148px;
           transform: translateX(0);
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
                        //获取png名字
                        String png_name =request.getParameter("png");
                    %>
                    <div id="content" class="sur-box">
                        <div class="box_head">
                            <h4 class="pattern-diagonal-stripes-sm text-pattern" data-aos="flip-left" data-aos-duration="1000">< Prognostic Analysis ></h4>
                            <div class="pattern-diagonal-stripes-sm stripe"></div>
                        </div>
                        <div class="sur_cont">
                            <div class="png_cont">
                                <img src="survival_png/<%= png_name%>.png" style="width: 600px;height: 600px; margin: auto; padding-top: 0px; margin-top: 20px;-webkit-box-shadow: 2px 4px 11px #737373; -moz-box-shadow: 2px 4px 11px #737373;">
                               <!-- <a id="download_survival" href="survival_png/<%= png_name%>.png" download>
                                    <button class="example_button" type="button">
                                        <span class="button__text">Variant.txt</span>
                                        <span class="button__icon"><svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 35 35" id="bdd05811-e15d-428c-bb53-8661459f9307" data-name="Layer 2" class="svg"><path d="M17.5,22.131a1.249,1.249,0,0,1-1.25-1.25V2.187a1.25,1.25,0,0,1,2.5,0V20.881A1.25,1.25,0,0,1,17.5,22.131Z"></path><path d="M17.5,22.693a3.189,3.189,0,0,1-2.262-.936L8.487,15.006a1.249,1.249,0,0,1,1.767-1.767l6.751,6.751a.7.7,0,0,0,.99,0l6.751-6.751a1.25,1.25,0,0,1,1.768,1.767l-6.752,6.751A3.191,3.191,0,0,1,17.5,22.693Z"></path><path d="M31.436,34.063H3.564A3.318,3.318,0,0,1,.25,30.749V22.011a1.25,1.25,0,0,1,2.5,0v8.738a.815.815,0,0,0,.814.814H31.436a.815.815,0,0,0,.814-.814V22.011a1.25,1.25,0,1,1,2.5,0v8.738A3.318,3.318,0,0,1,31.436,34.063Z"></path></svg></span>
                                    </button>
                                </a> -->
                            </div>
                        </div>
                    </div>
                    <script type="text/javascript">
                        AOS.init({
                            once:true,
                        })
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

</body>
</html>