package com.example.qlkh.model;

public class Export {
    private int p_id;
    private String product_name;
    private String car_name;
    private float price;
    private float sale_price;
    private String nameWareH;
    private String place;
    private String sub_place;
    private int inventory;
    private String unit;

    public Export(){

    }
    public Export(int p_id, String product_name, String car_name, float price, float sale_price, String nameWareH, String place, String sub_place, int inventory, String unit ){
        this.p_id = p_id;
        this.product_name = product_name;
        this.car_name = car_name;
        this.price = price;
        this.sale_price = sale_price;
        this.nameWareH = nameWareH;
        this.place = place;
        this.sub_place = sub_place;
        this.inventory = inventory;
        this.unit = unit;
    }

    public int getP_id() {
        return p_id;
    }

    public void setP_id(int p_id) {
        this.p_id = p_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getCar_name() {
        return car_name;
    }

    public void setCar_name(String car_name) {
        this.car_name = car_name;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getNameWareH() {
        return nameWareH;
    }

    public void setNameWareH(String nameWareH) {
        this.nameWareH = nameWareH;
    }

    public float getSale_price() {
        return sale_price;
    }

    public void setSale_price(float sale_price) {
        this.sale_price = sale_price;
    }

    public int getInventory() {
        return inventory;
    }

    public void setInventory(int inventory) {
        this.inventory = inventory;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
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
}
