// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.example.domain;

import com.example.domain.Pizza;

privileged aspect Pizza_Roo_JavaBean {
    
    public String Pizza.getDiameter() {
        return this.diameter;
    }
    
    public void Pizza.setDiameter(String diameter) {
        this.diameter = diameter;
    }
    
    public Float Pizza.getPrice() {
        return this.price;
    }
    
    public void Pizza.setPrice(Float price) {
        this.price = price;
    }
    
}
