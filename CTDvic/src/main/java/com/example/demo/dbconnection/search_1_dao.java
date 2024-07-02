package com.example.demo.dbconnection;
import org.springframework.stereotype.Repository;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
@Repository
public class search_1_dao {
    public search_1_dao() {
    }

    public String searchById(String id) throws SQLException {
        dbConnection c = new dbConnection();
        Connection conn = c.getcon();
        Statement st = conn.createStatement();
        ResultSet rs = null;
        StringBuffer sb = new StringBuffer();
        String sql = "select * from mutation where PMID='" + id + "'";
        for (rs = st.executeQuery(sql); rs.next(); sb.append("</tr>")){
            sb.append("<tr >");
            sb.append("<td>");
            sb.append(rs.getString(1));
            sb.append("</td>");
            sb.append("<td>");
            sb.append(rs.getString(2));
            sb.append("</td >");
            sb.append("<td>");
            sb.append(rs.getString(3));
            sb.append("</td >");
        }
        rs.close();
        st.close();
        conn.close();
        System.out.println(sb.toString());
        return sb.toString();
    }
}


