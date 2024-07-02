package com.example.demo.dbconnection;
import java.sql.*;
public class dbConnection {
    public Connection conn = null;
    public static String dataBaseName = "test";
    public static String name = "wyc";
    public static String pwd = "112233";

    //
    public dbConnection() {
    }
    public Connection getcon() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost/"+dataBaseName+"?useUnicode=true&characterEncoding=utf8", name, pwd);
        } catch (Exception e) {
            System.out.println("connection error" + e.getMessage());
        }
        return this.conn;
    }

    public Connection getcon(String dbName) {
        try {
            Class.forName("org.gjt.mm.mysql.Driver").newInstance();
            this.conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost/"+dbName+"?useUnicode=true&characterEncoding=utf8", name, pwd);
        } catch (Exception e) {
            System.out.println("connection error" + e.getMessage());
        }
        return this.conn;
    }

    public void CloseDataBase() {
        try {
            conn.close();
        } catch (Exception end) {
            System.err.println("error: " + end.getMessage());
            System.out.print("error" + end.getMessage());
        }
    }
}