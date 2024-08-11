package com.example.qlkh.model;

public class ListRelocation {
    private int id_freight;
    private product id_Product;
    private WareHouse wareHouse;
    private Shipment id_ShipmentNew;
    private String status_product;
    private String check;


    public String getCheck() {
        return check;
    }

    public void setCheck(String check) {
        this.check = check;
    }

    public WareHouse getWareHouse() {
        return wareHouse;
    }

    public void setWareHouse(WareHouse wareHouse) {
        this.wareHouse = wareHouse;
    }

    public product getId_Product() {
        return id_Product;
    }

    public void setId_Product(product id_Product) {
        this.id_Product = id_Product;
    }

    public int getId_freight() {
        return id_freight;
    }

    public void setId_freight(int id_freight) {
        this.id_freight = id_freight;
    }

    public Shipment getId_ShipmentNew() {
        return id_ShipmentNew;
    }

    public void setId_ShipmentNew(Shipment id_ShipmentNew) {
        this.id_ShipmentNew = id_ShipmentNew;
    }

    public String getStatus_product() {
        return status_product;
    }

    public void setStatus_product(String status_product) {
        this.status_product = status_product;
    }
}
