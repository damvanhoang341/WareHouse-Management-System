package com.example.qlkh.model;

public class ProductCategory {
    private int pId;
    private String productName;
    private Integer carId;
    private Integer inventory;
    private Integer supplierId;
    private Integer producerId;
    private String unit;
    private double importPrice;
    private double salesPrice;
    private Integer warehouseId;
    private String productCode;

    public String getProductCode() {
        return productCode;
    }

    public void setProductCode(String productCode) {
        this.productCode = productCode;
    }

    public ProductCategory() {
    }

    public ProductCategory(int pId, String productName, Integer supplierId, Integer carId, Integer inventory, Integer producerId, String unit, double importPrice, double salesPrice, Integer warehouseId, String productCode) {
        this.pId = pId;
        this.productName = productName;
        this.supplierId = supplierId;
        this.carId = carId;
        this.inventory = inventory;
        this.producerId = producerId;
        this.unit = unit;
        this.importPrice = importPrice;
        this.salesPrice = salesPrice;
        this.warehouseId = warehouseId;
        this.productCode = productCode;
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public Integer getCarId() {
        return carId;
    }

    public void setCarId(Integer carId) {
        this.carId = carId;
    }

    public Integer getInventory() {
        return inventory;
    }

    public void setInventory(Integer inventory) {
        this.inventory = inventory;
    }

    public Integer getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }

    public Integer getProducerId() {
        return producerId;
    }

    public void setProducerId(Integer producerId) {
        this.producerId = producerId;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public double getImportPrice() {
        return importPrice;
    }

    public void setImportPrice(double importPrice) {
        this.importPrice = importPrice;
    }

    public double getSalesPrice() {
        return salesPrice;
    }

    public void setSalesPrice(double salesPrice) {
        this.salesPrice = salesPrice;
    }

    public Integer getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(Integer warehouseId) {
        this.warehouseId = warehouseId;
    }
}
