package com.example.demo.dbconnection;
public class User {
    private int id;
    private String username;

    public String getPassword() {
        return password;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getId() {
        return id;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setId(int id) {
        this.id = id;
    }

    private String password;
    /* 省略get、set和带参构造方法 */
    public User(int id,String username,String password){
        this.id = id;
        this.username = username;
        this.password = password;
    }

}
