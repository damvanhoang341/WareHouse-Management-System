package com.example.qlkh.model;


import java.sql.Date;

public class ListExport {
    private int outputId;

    private Customers customer;
    private User sellerId;
    private Date outputDate;
    private float totalMoney;
    private float paid;
    private float amount_Owed;
    private String note;
    private float discount;
    private String envident;
    private String status;
    private String AddedExport;

    public ListExport(){

    }

    public ListExport(int outputId, Customers customer, User sellerId,
                      Date outputDate, Float totalMoney, Float paid,
                      Float amount_Owed, String note,float discount,
                      String envident, String status
    ){
        this.outputId = outputId;
        this.customer = customer;
        this.sellerId = sellerId;
        this.outputDate = outputDate;
        this.totalMoney = totalMoney;
        this.paid = paid;
        this.amount_Owed = amount_Owed;
        this.note = note;
        this.discount = discount;
        this.envident = envident;
        this.status = status;


    }


    public int getOutputId() {
        return outputId;
    }

    public void setOutputId(int outputId) {
        this.outputId = outputId;
    }

    public Customers getCustomer() {
        return customer;
    }

    public void setCustomer(Customers customer) {
        this.customer = customer;
    }

    public User getSellerId() {
        return sellerId;
    }

    public void setSellerId(User sellerId) {
        this.sellerId = sellerId;
    }

    public float getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(float totalMoney) {
        this.totalMoney = totalMoney;
    }

    public Date getOutputDate() {
        return outputDate;
    }

    public void setOutputDate(Date outputDate) {
        this.outputDate = outputDate;
    }

    public float getPaid() {
        return paid;
    }

    public void setPaid(float paid) {
        this.paid = paid;
    }

    public float getAmount_Owed() {
        return amount_Owed;
    }

    public void setAmount_Owed(float amount_Owed) {
        this.amount_Owed = amount_Owed;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getEnvident() {
        return envident;
    }

    public void setEnvident(String envident) {
        this.envident = envident;
    }

    public float getDiscount() {
        return discount;
    }

    public void setDiscount(float discount) {
        this.discount = discount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAddedExport() {
        return AddedExport;
    }

    public void setAddedExport(String addedExport) {
        AddedExport = addedExport;
    }
}
