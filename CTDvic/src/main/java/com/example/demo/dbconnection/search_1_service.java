package com.example.demo.dbconnection;
import java.sql.SQLException;


public class search_1_service {
    String id;

    public search_1_service(String id){
        this.id=id;
    }
    public String judgeid(){
        String result=null;
        search_1_dao s1d= new search_1_dao();
        if(id != null){
            try {
                result = s1d.searchById(id);

            } catch (SQLException e) {
                throw new RuntimeException(e);
            }

        }else{
            result = "id为空";
            System.out.println(result);
        }
        return result;
    }
}
