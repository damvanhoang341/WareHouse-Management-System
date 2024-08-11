package com.example.qlkh.model;

import java.sql.Date;

public class ListImport{
    private int Import_Id;
    private float Input_Amount;
    private float Debt;
    private User acc;
    private Date Input_Date;
    private String Check_Status;
    private String Problem;
    private String Envident;
    private WareHouse wareHouse;
    private String AddedImport;



    public ListImport(){

    }


    public WareHouse getWareHouse() {
        return wareHouse;
    }

    public void setWareHouse(WareHouse wareHouses) {
        wareHouse = wareHouses;
    }

    public int getImport_Id() {
        return Import_Id;
    }

    public void setImport_Id(int import_Id) {
        Import_Id = import_Id;
    }

    public float getInput_Amount() {
        return Input_Amount;
    }

    public void setInput_Amount(float input_Amount) {
        Input_Amount = input_Amount;
    }

    public float getDebt() {
        return Debt;
    }

    public void setDebt(float debt) {
        Debt = debt;
    }

    public User getAcc() {
        return acc;
    }

    public void setAcc(User Acc) {
        acc = Acc;
    }

    public Date getInput_Date() {
        return Input_Date;
    }

    public void setInput_Date(Date input_Date) {
        Input_Date = input_Date;
    }

    public String getCheck_Status() {
        return Check_Status;
    }

    public void setCheck_Status(String check_Status) {
        Check_Status = check_Status;
    }

    public String getProblem() {
        return Problem;
    }

    public void setProblem(String problem) {
        Problem = problem;
    }

    public String getEnvident() {
        return Envident;
    }

    public void setEnvident(String envident) {
        Envident = envident;
    }

    public String getAddedImport() {
        return AddedImport;
    }

    public void setAddedImport(String addedImport) {
        AddedImport = addedImport;
    }
}

