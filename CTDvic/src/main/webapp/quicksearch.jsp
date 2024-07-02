<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="java.util.Set"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
  <link href="css/quicksearch.css" rel="stylesheet">
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
                  <a href="index.html" class="active">Home</a>
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
          <%
            // quicksearch 参数
            String quicksearch = request.getParameter("quicksearch");
            String search_sql_variant = "SELECT * FROM mutation where disease = '"+quicksearch+"' OR gene = '"+quicksearch+"'";
            String search_sql_gene = "SELECT * FROM gene where disease = '"+quicksearch+"' OR gene = '"+quicksearch+"'";
            String search_sql_curation = "SELECT * FROM curation where disease = '"+quicksearch+"' OR gene = '"+quicksearch+"'";
          %>

          <%
            try {
              Class.forName("com.mysql.cj.jdbc.Driver");
              String url = "jdbc:mysql://localhost/ctdna_db"; //数据库名
              String username = "wyc"; //数据库用户名
              String password = "112233"; //数据库用户密码
              Connection conn = DriverManager.getConnection(url, username, password); //连接状态
          %>
            <%
              Statement stmt_variant = conn.createStatement();
              Statement stmt_gene = conn.createStatement();
              Statement stmt_curation = conn.createStatement();
              ResultSet rs_variant = stmt_variant.executeQuery(search_sql_variant);
              ResultSet rs_gene = stmt_gene.executeQuery(search_sql_gene);
              ResultSet rs_curation = stmt_curation.executeQuery(search_sql_curation);
              //是否添加统计疾病，基因数目
              //String[] set = {"re_variant","rs_gene","rs_curation"};
              //for(String i in set){

              //}
              //int columnIndex = 1; // 1-based index
              //Set<String> uniqueValues = new HashSet<>();
              // 遍历结果集
              //while (rs_variant.next()) {
               // String columnValue = rs.getString(columnIndex);
               // uniqueValues.add(columnValue);
              //}
              // 计算去重后的数目
              //int uniqueCount = uniqueValues.size();
              int num_variant = 0;
              while (rs_variant.next()){
                num_variant = num_variant +1;
              }
              int num_gene = 0;
              while (rs_gene.next()){
                num_gene = num_gene +1;
              }
              int num_curation = 0;
              while (rs_curation.next()){
                num_curation = num_curation +1;
              }
            %>
            <div id="content" class="qucs-box" style="background-color: white">
              <div class="box_head">
                <h4 class="pattern-diagonal-stripes-sm text-pattern" data-aos="flip-left" data-aos="zoom-in" data-aos-duration="600" data-aos-delay="700">< Quick search result ></h4>
                <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
                <p>The<span class="number"> quick search</span> results of<span class="emphasis">"<%= quicksearch%>"</span> are as follows:</p>
                <a href="helps.html#help3_1_3"><img id="wenhao" src="IMAGE/wenhao.png"></a>
                <div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
              </div>
              <div class="row clearfix">
                <div class="col-md-12 col-sm-12 column qs-conall">
                  <div class="col-md-4 col-sm-4 column qs-cont">
                    <div class="col-md-6 col-sm-6 column"><img src="IMAGE/quicksearch_variant.png"></div>
                    <div class="col-md-6 col-sm-6 column qs-count-de"><h3>Variant-Level</h3><h6>Record Counts: <%= num_variant%></h6><a href="quickSearch_variant_view.jsp?para=<%= quicksearch%>"><button class="view_detail">view</button></a></div>
                  </div>
                  <div class="col-md-4 col-sm-4 column qs-cont">
                    <div class="col-md-6 col-sm-6 column"><img src="IMAGE/quicksearch_gene.png"></div>
                    <div class="col-md-6 col-sm-6 column qs-count-de"><h3>Gene-Level</h3><h6>Record Counts: <%= num_gene%></h6><a href="quickSearch_gene_view.jsp?para=<%= quicksearch%>"><button class="view_detail">view</button></a></div>
                  </div>
                  <div class="col-md-4 col-sm-4 column qs-cont-right">
                    <div class="col-md-6 col-sm-6 column"><img src="IMAGE/quicksearch_curation.png"></div>
                    <div class="col-md-6 col-sm-6 column qs-count-de"><h3>Prediction Hotspot Mutations</h3><h6>Record Counts: <%= num_curation%></h6><a href="quickSearch_curation_view.jsp?para=<%= quicksearch%>"><button class="view_detail">view</button></a></div>
                  </div>
                </div>
              </div>
            </div>

          <%
              rs_variant.close();
              rs_gene.close();
              rs_curation.close();
            } catch (SQLException e) {
              e.printStackTrace();
            }

          %>

          <script type="text/javascript">
            AOS.init({
              once:true,
            })
            //定义显示字符长度
            var remarkShowLength = 50;
            //切换显示备注信息，显示部分或者全部
            function changeShowRemarks(obj){//obj是td
              var content = $(obj).attr("data-remarks");
              if(content != null && content != ''){
                if($(obj).attr("data-show") == 'true'){//当前显示的是详细备注，切换到显示部分
                  //$(obj).removeAttr('isDetail');//remove也可以
                  $(obj).attr('data-show',false);
                  $(obj).html(getPartialRemarksHtml(content));
                }else{//当前显示的是部分备注信息，切换到显示全部
                  $(obj).attr('data-show',true);
                  $(obj).html(getTotalRemarksHtml(content));
                }
              }
            }
            //部分备注信息
            function getPartialRemarksHtml(remarks){
              return remarks.substr(0,remarkShowLength) + '&nbsp;&nbsp;<a href="javascript:void(0);" ><b>...</b></a>';//&nbsp空格占位符
            }

            //全部备注信息
            function getTotalRemarksHtml(remarks){
              return remarks + '&nbsp;&nbsp;<a href="javascript:void(0);" >收起</a>';
            }
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
                ],
                "createdRow": function( row, data, dataIndex ) { //row是dom行元素 ，data是行中所有列的数据，用数组或对象来表示，dataindex表示行索引（从0开始）

                  for (var i=6; i<=13; i++){
                    var cellValue = data[i]; // 获取第i列的单元格值
                    if (cellValue.length > remarkShowLength) {
                      $(row).children('td').eq(i).attr('onclick', 'javascript:changeShowRemarks(this);'); //添加点击事件
                      $(row).children('td').eq(i).attr('data-remarks', cellValue); // 存储备注信息，data-remarks为自定义属性
                      $(row).children('td').eq(i).attr('data-show', true); // 添加自定义属性存储展开收缩状态
                      $(row).children('td').eq(i).html(cellValue.substr(0,remarkShowLength) + '&nbsp;&nbsp;<a href="javascript:void(0);" ><b>...</b></a>') //只显示部分信息
                    }
                  }
                },
                "columnDefs": [{"width": "2.3%", "targets": [0,1,2] },{"width": "4.3%", "targets": [3,4,5] },{"width": "8%", "targets": [6,7,8,9,10,11,12,13] } ]


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

</body>
</html>