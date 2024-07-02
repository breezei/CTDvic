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
									<a href="#" class="dropdown-toggle active" data-toggle="dropdown" style="background-color: transparent !important;">Search<strong class="caret"></strong></a>
									<ul class="dropdown-menu">
										<li>
											<a href="search_mo.html" class="active">Variant-orient(VL)</a>
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

						//接收mutation type
						String mt=request.getParameter("mutation_type");
						String mt_ally=null;
						String j="all_mutation_type";
						if(mt.equals(j)){
							mt_ally="'missense','amplification','loss','methylation','gene fusion'";
						}else{
							mt_ally="'"+mt+"'";
						}

						//接收mutation_describe   //生成查询的SQL语句
						String  search_sql;
						String md= request.getParameter("mutation_describe");
						if(request.getParameter("mutation_describe")==null || md.equals("all")){
							search_sql="SELECT * FROM mutation where disease in ("+disease_ally+") AND gene in ("+gene_ally+") AND `variant type` in ("+mt_ally+")";
						}
						else{
							String str = md;
							String[] strlist = str.split("\r\n");
							String md_ally="'"+strlist[0]+"'";
							if(strlist.length>1){
								for(int i=1;i<strlist.length;i++){
									md_ally=md_ally+",'"+strlist[i]+"'";
								}
							}
							search_sql="SELECT * FROM mutation where disease in ("+disease_ally+") AND gene in ("+gene_ally+") AND `variant type` in ("+mt_ally+") AND `variant description` in ("+md_ally+")";
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
							<h4 class="pattern-diagonal-stripes-sm text-pattern" data-aos="zoom-in" data-aos-duration="600" data-aos-delay="700"> < Variant-orient(VL) Search Result ></h4>
							<div style="width: 100%" class="pattern-diagonal-stripes-sm stripe"></div>
							<a href="helps.html#help3_2_5"><img id="wenhao" src="IMAGE/wenhao.png"></a>
						</div>
						<div style="margin-top: 10px">
							<table id="mo_result" class="display" role="grid" aria-describedby="example_info" >
								<thead>
								<tr>
									<th>Detail</th>
									<th>PMID</th>
									<th>Gene</th>
									<th>Variant Type</th>
									<th>Variant Description</th>
									<th>Disease</th>
									<th>Body Fluid</th>
									<th>Sequencing Method</th>
									<th>Experiment</th>
									<th>Mechanism</th>
									<th>Drug Resistance</th>
									<th>Disease Prognosis</th>
									<th>characteristic Of Tumors</th>
									<th>Prospects For Detection</th>
									<th>Metastasis Biomarker</th>
									<th>Therapy</th>
									<th>Others</th>
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
									while (rs.next()) {
										out.println("<tr><td> <a href='mutation_detail.jsp?num="+rs.getString(1)+"' target='_blank'>detail</a></td><td> <a href='http://www.ncbi.nlm.nih.gov/pubmed/"
												+rs.getString(2)+"' target='_blank'>"+rs.getString(2)+"</a></td><td>"

												+rs.getString(3)+"</td><td>"
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
												+rs.getString(17)+"</td></tr>"

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
							return remarks + '&nbsp;&nbsp;<a href="javascript:void(0);" >collapse</a>';
						}
						$(document).ready(function() {
								$('#mo_result').dataTable({
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
									{
										extend: 'copy',
										className: 'custom-copy-button',
										text: 'copy',
									},
									'excelHtml5',
									'csvHtml5',
								],
								"createdRow": function( row, data, dataIndex ) { //row是dom行元素 ，data是行中所有列的数据，用数组或对象来表示，dataindex表示行索引（从0开始）

									for (var i=7; i<=16; i++){
										var cellValue = data[i]; // 获取第9列的单元格值
										if (cellValue.length > remarkShowLength) {
											$(row).children('td').eq(i).attr('onclick', 'javascript:changeShowRemarks(this);'); //添加点击事件
											$(row).children('td').eq(i).attr('data-remarks', cellValue); // 存储备注信息，data-remarks为自定义属性
											$(row).children('td').eq(i).attr('data-show', true); // 添加自定义属性存储展开收缩状态
											$(row).children('td').eq(i).html(cellValue.substr(0,remarkShowLength) + '&nbsp;&nbsp;<a href="javascript:void(0);" ><b>...</b></a>') //只显示部分信息
										}
									}
								},
								"columnDefs": [{"width": "2.3%", "targets": [0,1,2] },{"width": "4.3%", "targets": [3,4,5,6] },{"width": "6%", "targets": [7,8,9] },{"width": "8%", "targets": [10,11,12,13,14,15,16] } ]


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