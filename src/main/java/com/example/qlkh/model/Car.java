package com.example.qlkh.model;

public class Car {
    private int carId;
    private String carName;
    private String carOrigin;
    private String carDescription;

    public String getCarOrigin() {
        return carOrigin;
    }

    public void setCarOrigin(String carOrigin) {
        this.carOrigin = carOrigin;
    }

    public String getCarDescription() {
        return carDescription;
    }

    public void setCarDescription(String carDescription) {
        this.carDescription = carDescription;
    }

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    @Override
    public String toString() {
        return "Car{" +
                "carId=" + carId +
                ", carName='" + carName + '\'' +
                ", carOrigin='" + carOrigin + '\'' +
                ", carDescription='" + carDescription + '\'' +
                '}';
    }
}
