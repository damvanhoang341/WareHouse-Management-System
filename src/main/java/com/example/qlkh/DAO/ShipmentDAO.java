package com.example.qlkh.DAO;

import com.example.qlkh.model.Export;
import com.example.qlkh.model.Shipment;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ShipmentDAO extends DAO{
    public ArrayList<Shipment> getShipmentById(int id) {
        ArrayList<Shipment> shipments = new ArrayList<>();
        String sql = "SELECT * FROM swp_project.shipment s where s.Warehouse_Id = ?;";
        try {
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Shipment s = new Shipment();
                s.setShipment_Id(resultSet.getInt("Shipment_Id"));
                s.setWarehouse_Id(resultSet.getInt("Warehouse_Id"));
                s.setPlace(resultSet.getString("Place"));
                s.setSub_place(resultSet.getString("Place"));
                s.setPlace_include(resultSet.getString("Place"));
                shipments.add(s);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching warehouses: " + e.getMessage());
        }
        return shipments;
    }

//    public Shipment getById(int id) {
//        Shipment object = null;
//        String sql = "SELECT * FROM Warehouse WHERE Warehouse_Id = ?";
//        try {
//            PreparedStatement statement = con.prepareStatement(sql);
//            statement.setInt(1, id);
//
//            ResultSet resultSet = statement.executeQuery();
//
//            if (resultSet.next()) {
//                object = new Shipment();
//                object.setId(resultSet.getInt("Warehouse_Id"));
//                object.setName(resultSet.getString("Warehouse_Name"));
//            }
//        } catch (Exception e) {
//            System.out.println("Get ware house: " + e);
//        }
//
//        return object;
//    }

    public static void main(String[] args) {
        ShipmentDAO dao = new ShipmentDAO();
        List<Shipment> s = dao.getShipmentById(1);
        for (int i = 0; i < s.size(); i++) {
            System.out.println("i =" + i);
            System.out.println("size = " + s.size());
            System.out.println(s.get(i).getPlace());
        }
    }
}
