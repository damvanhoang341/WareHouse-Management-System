package com.example.qlkh.model;

public class DetailImport {

    private int Detail_Id;
    private int Import_Id;
    private product Prod;
    private int import_quantity;
    private double product_total;
    private String AddedImport;
    private String Status;

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }

    public int getDetail_Id() {
        return Detail_Id;
    }

    public void setDetail_Id(int detail_Id) {
        Detail_Id = detail_Id;
    }

    public int getImport_Id() {
        return Import_Id;
    }

    public void setImport_Id(int import_Id) {
        Import_Id = import_Id;
    }

    public product getProd() {
        return Prod;
    }

    public void setProd(product prod) {
        Prod = prod;
    }

    public int getImport_quantity() {
        return import_quantity;
    }

    public void setImport_quantity(int import_quantity) {
        this.import_quantity = import_quantity;
    }

    public double getProduct_total() {
        return product_total;
    }

    public void setProduct_total(double product_total) {
        this.product_total = product_total;
    }

    public String getAddedImport() {
        return AddedImport;
    }

    public void setAddedImport(String addedImport) {
        AddedImport = addedImport;
    }
}
