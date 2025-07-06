package com.salesapp.dto;

import com.salesapp.entity.User;

public class LoginResponse {
    
    private String token;
    private User user;
    private String refreshToken;
    private long expiresIn;
    
    // Constructors
    public LoginResponse() {}
    
    public LoginResponse(String token, User user) {
        this.token = token;
        this.user = user;
        this.refreshToken = null;
        this.expiresIn = 86400000; // 24 hours in milliseconds
    }
    
    public LoginResponse(String token, User user, String refreshToken, long expiresIn) {
        this.token = token;
        this.user = user;
        this.refreshToken = refreshToken;
        this.expiresIn = expiresIn;
    }
    
    // Getters and Setters
    public String getToken() {
        return token;
    }
    
    public void setToken(String token) {
        this.token = token;
    }
    
    public User getUser() {
        return user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    public String getRefreshToken() {
        return refreshToken;
    }
    
    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }
    
    public long getExpiresIn() {
        return expiresIn;
    }
    
    public void setExpiresIn(long expiresIn) {
        this.expiresIn = expiresIn;
    }
} 