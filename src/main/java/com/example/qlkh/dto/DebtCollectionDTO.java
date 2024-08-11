package com.example.qlkh.dto;

import java.math.BigDecimal;

public class DebtCollectionDTO {
    private String name;
    private String phone;
    private String address;
    private BigDecimal debt;

    public DebtCollectionDTO() {
    }

    public DebtCollectionDTO(String name, String phone, String address, BigDecimal debt) {
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.debt = debt;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public BigDecimal getDebt() {
        return debt;
    }

    public void setDebt(BigDecimal debt) {
        this.debt = debt;
    }
}
