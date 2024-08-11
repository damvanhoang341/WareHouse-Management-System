package com.example.qlkh.model;

import java.util.Date;

public class Revenue {
    private int id;
    private double money;
    private Date date;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    @Override
    public String toString() {
        return "Revenue{" +
                "id=" + id +
                ", money=" + money +
                ", date=" + date +
                '}';
    }
}
