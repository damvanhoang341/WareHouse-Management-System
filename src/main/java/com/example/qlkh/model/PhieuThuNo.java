package com.example.qlkh.model;

import java.util.Date;

public class PhieuThuNo {
    private Date date;
    private String customersName;
    private String employeesName;
    private double money;
    private String phuongThucChuyen;
    private String Code;
    private String des;

    public PhieuThuNo(){}

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getCustomersName() {
        return customersName;
    }

    public void setCustomersName(String customersName) {
        this.customersName = customersName;
    }

    public String getEmployeesName() {
        return employeesName;
    }

    public void setEmployeesName(String employeesName) {
        this.employeesName = employeesName;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public String getPhuongThucChuyen() {
        return phuongThucChuyen;
    }

    public void setPhuongThucChuyen(String phuongThucChuyen) {
        this.phuongThucChuyen = phuongThucChuyen;
    }

    public String getCode() {
        return Code;
    }

    public void setCode(String code) {
        Code = code;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    @Override
    public String toString() {
        return "PhieuThuNo{" +
                "date=" + date +
                ", customersName='" + customersName + '\'' +
                ", employeesName='" + employeesName + '\'' +
                ", money=" + money +
                ", phuongThucChuyen='" + phuongThucChuyen + '\'' +
                ", Code='" + Code + '\'' +
                ", des='" + des + '\'' +
                '}';
    }
}
