package com.example.qlkh.model;

public class producers {
    private int Producer_Id;
    private String Producer_Name;

    public producers() {

    }

    public int getProducer_Id() {
        return Producer_Id;
    }

    public void setProducer_Id(int producer_Id) {
        Producer_Id = producer_Id;
    }

    public String getProducer_Name() {
        return Producer_Name;
    }

    public void setProducer_Name(String producer_Name) {
        Producer_Name = producer_Name;
    }

    @Override
    public String toString() {
        return "producers{" +
                "Producer_Id=" + Producer_Id +
                ", Producer_Name='" + Producer_Name + '\'' +
                '}';
    }
}
