package it.itp4511.ea.bean;

import java.io.Serializable;

public class UserBean implements Serializable {
    private String email;
    private String id;
    private String username;
    private int role;
    private String phone;

    public UserBean() {
    }

    public UserBean(String id, String email, String username, String phone, int role) {
        this.email = email;
        this.id = id;
        this.username = username;
        this.role = role;
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
