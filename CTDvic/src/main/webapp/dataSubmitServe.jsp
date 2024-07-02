<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%@ page import="java.io.*" %>
        <%@ page import="java.sql.*"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%  String paperDoi =request.getParameter("PaperDoi");
    String DiseaseName =request.getParameter("DiseaseName");
    String Gene =request.getParameter("Gene");
    String mutationType =request.getParameter("MutationType");
    String mutationDescription =request.getParameter("VariantDescription");
    String bodyFluid =request.getParameter("BodyFluid");
    String sequenceMethod =request.getParameter("SequenceMethod");
    String experiment =request.getParameter("Experiment");
    String function =request.getParameter("Function");
    String Email =request.getParameter("Email");
    String sql_search="insert into datasubmit(Doi,Disease,Gene,`Mutation Type`,`Mutation Descrioption`,`Body Fluid`,`Sequence Method`,Experiment,Function,Email) values ('"+paperDoi+"','"+DiseaseName+"','"+Gene+"','"+mutationType+"','"+mutationDescription+"','"+ bodyFluid+"','"+ sequenceMethod+"','"+experiment+"','"+function+"','"+Email+"')";
	if (paperDoi != null || DiseaseName != null) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost/ctdna_db"; //数据库名
			String username = "wyc"; //数据库用户名
			String password = "112233"; //数据库用户密码
			Connection conn = DriverManager.getConnection(url, username, password); //连接状态
			Statement stmt = null;
			String sql = sql_search;
			stmt = conn.createStatement();
			int rs = stmt.executeUpdate(sql);
			conn.close();
			if (rs == 1) {
				out.println("insert success");
			}
		} catch (Exception e) {
			e.printStackTrace();
			out.println("Database connection failure...");
		}
	}else {
		return;
	}
    %>
</body>
</html>