package com.example.demo.entity;
public class Error_entity {
    private String name;
    private String message;
    public Error_entity(String name, String message){
        this.name = name;
        this.message = message;
    }
    public void setName(String name){
        this.name = name;
    }
    public String getName(){
        return name;
    }
    public void setMessage(String message){
        this.message = message;
    }
    public String getMessage(){
        return message;
    }
}
