package com.example.qlkh.DAO;

import com.example.qlkh.model.product;
import com.example.qlkh.model.Car;
import com.example.qlkh.model.Suppliers;
import com.example.qlkh.model.producers;
import com.example.qlkh.model.WareHouse;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class InventoryDAO extends DAO {
    public List<product> listProductsByPage(String search, int ware, String sort, int offset, int noOfRecords) {
        List<product> listProduct = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS p.Image_Link, p.P_Id, p.Product_Name, p.Car_Id, p.Inventory, p.Supplier_Id, p.Producer_Id,p.Unit,p.Import_Price, p.Sales_Price,sh.Warehouse_Id, p.Product_code, "
                + "c.Car_Name, s.Supplier_Name,po.Producer_Name ,w.Warehouse_Name, SH.Place "
                + "FROM swp_project.product p "
                + "JOIN swp_project.car c ON p.Car_Id = c.Car_Id "
                + "JOIN swp_project.supplier s ON p.Supplier_Id = s.Supplier_Id "
                + "LEFT JOIN swp_project.producer po ON p.Producer_Id = po.Producer_Id "
                + " LEFT Join swp_project.shipment as SH on SH.Shipment_Id = p.Shipment_Id "
                + "LEFT JOIN swp_project.warehouse as w ON SH.Warehouse_Id = w.Warehouse_Id "
                + "WHERE p.Inventory > 0 ";

        if (!search.isEmpty()) {
            sql += " AND p.Product_Name LIKE ?";
        }
        if (ware > 0) {
            sql += " AND w.Warehouse_Id = ?";
        }
        if (!sort.isEmpty()) {
            sql += " ORDER BY p.P_Id " + sort;
        }
        sql += " LIMIT ?, ?";

        try {
            PreparedStatement statement = con.prepareStatement(sql);
            int index = 1;
            if (!search.isEmpty()) {
                statement.setString(index++, "%" + search + "%");
            }
            if (ware > 0) {
                statement.setInt(index++, ware);
            }
            statement.setInt(index++, offset);
            statement.setInt(index, noOfRecords);

            ResultSet rs = statement.executeQuery();

            while (rs.next()) {
                product pro = new product();
                pro.setP_id(rs.getInt("P_Id"));
                pro.setProduct_name(rs.getString("Product_Name"));
                Car car = new Car();
                car.setCarName(rs.getString("Car_Name"));
                pro.setCar_id(car);
                pro.setInventory(rs.getInt("Inventory"));
                Suppliers suppliers = new Suppliers();
                suppliers.setSupplierId(rs.getInt("Supplier_Id"));
                suppliers.setSupplierName(rs.getString("Supplier_Name"));
                pro.setSupplier_id(suppliers);
                producers producer = new producers();
                producer.setProducer_Id(rs.getInt("Producer_Id"));
                producer.setProducer_Name(rs.getString("Producer_Name"));
                pro.setProducer_Id(producer);
                pro.setUnit(rs.getString("Unit"));
                pro.setImport_price(rs.getDouble("Import_Price"));
                pro.setSale_price(rs.getDouble("Sales_Price"));
                WareHouse warehouse = new WareHouse();
                warehouse.setId(rs.getInt("Warehouse_Id"));
                warehouse.setName(rs.getString("Warehouse_Name"));
                pro.setWarehouse_id(warehouse);
                pro.setPlace(rs.getString("place"));
                pro.setImage_Link(rs.getString("Image_Link"));
                pro.setProductCode(rs.getString("Product_code"));
                listProduct.add(pro);
            }
        } catch (SQLException e) {
            System.out.println("Get all: " + e);
        }
        return listProduct;
    }

    public int getNumberOfRows(String search, int ware, String sort) {
        String sql = "SELECT COUNT(*) FROM swp_project.product p "
                + "JOIN swp_project.car c ON p.Car_Id = c.Car_Id "
                + "JOIN swp_project.supplier s ON p.Supplier_Id = s.Supplier_Id "
                + "LEFT JOIN swp_project.producer po ON p.Producer_Id = po.Producer_Id "
                + " LEFT Join swp_project.shipment as SH on SH.Shipment_Id = p.Shipment_Id "
                + "LEFT JOIN swp_project.warehouse as w ON SH.Warehouse_Id = w.Warehouse_Id "
                + "WHERE p.Inventory > 0 ";

        if (!search.isEmpty()) {
            sql += " AND p.Product_Name LIKE ?";
        }
        if (ware > 0) {
            sql += " AND w.Warehouse_Id = ?";
        }
        if (!sort.isEmpty()) {
            sql += " ORDER BY p.P_Id " + sort;
        }

        try {
            PreparedStatement statement = con.prepareStatement(sql);
            int index = 1;
            if (!search.isEmpty()) {
                statement.setString(index++, "%" + search + "%");
            }
            if (ware > 0) {
                statement.setInt(index, ware);
            }

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get count: " + e);
        }
        return 0;
    }
}
