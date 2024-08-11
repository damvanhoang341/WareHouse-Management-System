package com.example.qlkh.DAO;

import com.example.qlkh.model.DetailImport;
import com.example.qlkh.model.WareHouse;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WareHouseDAO extends DAO{
    public List<WareHouse> getAllWarehouses() {
        List<WareHouse> warehouses = new ArrayList<>();
        String sql = "SELECT * FROM Warehouse";
        try {
            PreparedStatement statement = con.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                WareHouse warehouse = new WareHouse();
                warehouse.setId(resultSet.getInt("Warehouse_Id"));
                warehouse.setName(resultSet.getString("Warehouse_Name"));
                warehouses.add(warehouse);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching warehouses: " + e.getMessage());
        }
        return warehouses;
    }

    public WareHouse getById(int id) {
        WareHouse obj = new WareHouse();
        try {
            String sql = "Select * FROM swp_project.warehouse WHERE Warehouse_Id = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) { // Move the cursor to the first row
                obj.setId(resultSet.getInt("Warehouse_Id"));
                obj.setName(resultSet.getString("Warehouse_Name"));
            } else {
                System.out.println("No warehouse found with id: " + id);
            }

        } catch (Exception e) {
            System.out.println("Get ware house: " + e);
        }

        return obj;
    }

    public static void main(String[] args) {
        WareHouseDAO dao = new WareHouseDAO();
        WareHouse d = dao.getById(1);

            System.out.println(d.getId());

    }
}
