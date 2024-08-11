package com.example.qlkh.model;

public class Shipment {
    private int shipment_Id;
    private int warehouse_Id;
    private String place;
    private String sub_place;
    private String place_include;

    public Shipment(){

    }
    public Shipment(int shipment_Id, int warehouse_Id, String place, String sub_place, String place_include) {
        this.shipment_Id = shipment_Id;
        this.warehouse_Id = warehouse_Id;
        this.place = place;
        this.sub_place = sub_place;
        this.place_include = place_include;
    }

    public int getShipment_Id() {
        return shipment_Id;
    }

    public void setShipment_Id(int shipment_Id) {
        this.shipment_Id = shipment_Id;
    }

    public int getWarehouse_Id() {
        return warehouse_Id;
    }

    public void setWarehouse_Id(int warehouse_Id) {
        this.warehouse_Id = warehouse_Id;
    }

    public void setPlace(String place) {
        String[] parts = place.split("-");
        this.place = parts[0];
    }

    public void setSub_place(String place) {
        String[] parts = place.split("-");
        this.sub_place = parts[1];
    }

    public String getPlace() {
        return place;
    }

    public String getSub_place() {
        return sub_place;
    }

    public String getPlace_include() {
        return place_include;
    }

    public void setPlace_include(String place_include) {
        this.place_include = place_include;
    }
}
