package com.example.qlkh.model;

public class DetailExport {

    private int Detail_Id;
    private String Output_Id;
    private product Prod;
    private String nShipment;
    private String nWarehouse;
    private int export_quantity;
    private double product_total;
    private String AddedExport;
    private String Status;

    public int getDetail_Id() {
        return Detail_Id;
    }

    public void setDetail_Id(int detail_Id) {
        Detail_Id = detail_Id;
    }

    public String getOutput_Id() {
        return Output_Id;
    }

    public void setOutput_Id(String output_Id) {
        Output_Id = output_Id;
    }

    public product getProd() {
        return Prod;
    }

    public void setProd(product prod) {
        Prod = prod;
    }

    public String getnShipment() {
        return nShipment;
    }

    public void setnShipment(String nShipment) {
        this.nShipment = nShipment;
    }

    public String getnWarehouse() {
        return nWarehouse;
    }

    public void setnWarehouse(String nWarehouse) {
        this.nWarehouse = nWarehouse;
    }

    public int getExport_quantity() {
        return export_quantity;
    }

    public void setExport_quantity(int export_quantity) {
        this.export_quantity = export_quantity;
    }

    public double getProduct_total() {
        return product_total;
    }

    public void setProduct_total(double product_total) {
        this.product_total = product_total;
    }

    public String getAddedExport() {
        return AddedExport;
    }

    public void setAddedExport(String addedExport) {
        AddedExport = addedExport;
    }

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }
}
