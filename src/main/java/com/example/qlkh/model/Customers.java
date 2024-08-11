package com.example.qlkh.model;

public class Customers {
    private int customerId;
    private CustomerType ct_Id;
    private String customerName;
    private String customerPhone;
    private String customerAddress;
    private String customerTax;
    private double customerDebt;

    public double getCustomerDebt() {
        return customerDebt;
    }

    public void setCustomerDebt(double customerDebt) {
        this.customerDebt = customerDebt;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public String getCustomerTax() {
        return customerTax;
    }

    public void setCustomerTax(String customerTax) {
        this.customerTax = customerTax;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public CustomerType getCt_Id() {
        return ct_Id;
    }

    public void setCt_Id(CustomerType ct_Id) {
        this.ct_Id = ct_Id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    @Override
    public String toString() {
        return "Customers{" +
                "customerId=" + customerId +
                ", ct_Id=" + ct_Id +
                ", customerName='" + customerName + '\'' +
                ", customerPhone='" + customerPhone + '\'' +
                ", customerAddress='" + customerAddress + '\'' +
                ", customerTax='" + customerTax + '\'' +
                ", customerDebt=" + customerDebt +
                '}';
    }
}
