package com.example.qlkh.model;

public class product {
    private int p_id;
    private String product_name;
    private Car car_id;
    private int inventory;
    private producers producer_Id;
    private String unit;
    private Suppliers supplier_id;
    private double import_price;
    private double sale_price;
    private WareHouse warehouse_id;
    private int producer;
    private Shipment shipment;
    private String image_Link;
    private String productCode;
    private String desc;

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    private String place;

    public product() {
    }

    public Shipment getShipment() {
        return shipment;
    }

    public void setShipment(Shipment shipment) {
        this.shipment = shipment;
    }

    public String getImage_Link() {
        return image_Link;
    }

    public void setImage_Link(String image_Link) {
        this.image_Link = image_Link;
    }

    public int getP_id() {
        return p_id;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
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

    public Car getCar_id() {
        return car_id;
    }

    public void setCar_id(Car car_id) {
        this.car_id = car_id;
    }

    public int getInventory() {
        return inventory;
    }

    public void setInventory(int inventory) {
        this.inventory = inventory;
    }

    public Suppliers getSupplier_id() {
        return supplier_id;
    }

    public void setSupplier_id(Suppliers supplier_id) {
        this.supplier_id = supplier_id;
    }

    public double getImport_price() {
        return import_price;
    }

    public void setImport_price(double import_price) {
        this.import_price = import_price;
    }

    public double getSale_price() {
        return sale_price;
    }

    public void setSale_price(double sale_price) {
        this.sale_price = sale_price;
    }

    public WareHouse getWarehouse_id() {
        return warehouse_id;
    }

    public void setWarehouse_id(WareHouse warehouse_id) {
        this.warehouse_id = warehouse_id;
    }

    public producers getProducer_Id() {
        return producer_Id;
    }

    public void setProducer_Id(producers producer_Id) {
        this.producer_Id = producer_Id;
    }

    public int getProducer() {
        return producer;
    }

    public void setProducer(int producer) {
        this.producer = producer;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    @Override
    public String toString() {
        return "product{" +
                "p_id=" + p_id +
                ", product_name='" + product_name + '\'' +
                ", car_id=" + car_id +
                ", inventory=" + inventory +
                ", producer_Id=" + producer_Id +
                ", unit='" + unit + '\'' +
                ", supplier_id=" + supplier_id +
                ", import_price=" + import_price +
                ", sale_price=" + sale_price +
                ", warehouse_id=" + warehouse_id +
                ", producer=" + producer +
                ", shipment=" + shipment +
                ", image_Link='" + image_Link + '\'' +
                ", productCode='" + productCode + '\'' +
                ", place='" + place + '\'' +
                '}';
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
