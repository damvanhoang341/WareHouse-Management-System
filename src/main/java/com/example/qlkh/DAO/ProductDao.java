package com.example.qlkh.DAO;

import com.example.qlkh.model.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDao extends DAO {

    public ArrayList<product> getAllProduct() {
        ArrayList<product> list = new ArrayList<>();
        String sql = "SELECT p.* ,  c.Car_Name, s.Supplier_Name,po.Producer_Name ,shi.Place,shi.Warehouse_Id, w.Warehouse_Name FROM swp_project.product p \n" +
                "                JOIN swp_project.car c ON p.Car_Id = c.Car_Id \n" +
                "                JOIN swp_project.supplier s ON p.Supplier_Id = s.Supplier_Id \n" +
                "                LEFT JOIN swp_project.producer po ON p.Producer_Id = po.Producer_Id \n" +
                "                JOIN swp_project.shipment shi ON p.Shipment_Id = shi.Shipment_Id \n" +
                "                Join swp_project.warehouse w on w.Warehouse_Id = shi.Warehouse_Id\n" +
                "                WHERE p.Inventory > 0\n" +
                "                ORDER BY p.P_Id ASC";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
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
                pro.setImport_price(rs.getDouble("Import_Price"));
                pro.setSale_price(rs.getDouble("Sales_Price"));
                Shipment shipment = new Shipment();
                shipment.setShipment_Id(rs.getInt("Shipment_Id"));
                shipment.setWarehouse_Id(rs.getInt("Warehouse_Id"));
                shipment.setPlace(rs.getString("Place"));
                shipment.setPlace_include(rs.getString("Place"));
                WareHouse w = new WareHouse();
                w.setId(rs.getInt("Warehouse_Id"));
                w.setName(rs.getString("Warehouse_Name"));
                pro.setWarehouse_id(w);
                pro.setShipment(shipment);
                pro.setProductCode(rs.getString("Product_code"));
                pro.setUnit(rs.getString("Unit"));
                pro.setImage_Link(rs.getString("Image_Link"));
                pro.setDesc(rs.getString("Description"));
                list.add(pro);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    //so luong mat hang khong ton kho
    public int countAllProducts() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS count FROM swp_project.product WHERE Inventory > 0";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println("Error while counting products: " + e.getMessage());
        }
        return count;
    }

    //So lg mat hang ke ca khong ton kho
    public int countAllProduct() {
        int count = 0;
        String sql = "SELECT COUNT(*) AS count FROM swp_project.product";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException e) {
            System.out.println("Error while counting products: " + e.getMessage());
        }
        return count;
    }

    public List<product> getProductPrice() {
        List<product> list = new ArrayList<>();
        String sql = "SELECT p.P_Id, p.Product_Name, p.Car_Id, p.Inventory, p.Supplier_Id, p.Producer_Id, p.Unit, p.Import_Price, p.Sales_Price, p.Shipment_Id, p.Product_code, "
                + "c.Car_Name, s.Supplier_Name, po.Producer_Name, shi.Place, shi.Warehouse_Id "
                + "FROM swp_project.product p "
                + "JOIN swp_project.car c ON p.Car_Id = c.Car_Id "
                + "JOIN swp_project.supplier s ON p.Supplier_Id = s.Supplier_Id "
                + "LEFT JOIN swp_project.producer po ON p.Producer_Id = po.Producer_Id "
                + "JOIN swp_project.shipment shi ON p.Shipment_Id = shi.Shipment_Id "
                + "WHERE p.Inventory > 0 "
                + "ORDER BY p.P_Id ASC"; // Default sorting by P_Id in ascending order

        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                product pro = new product();
                pro.setP_id(rs.getInt("P_Id"));
                pro.setProduct_name(rs.getString("Product_Name"));

                Car car = new Car();
                car.setCarId(rs.getInt("Car_Id"));  // Đảm bảo CarId được đặt
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

                Shipment shipment = new Shipment();
                shipment.setShipment_Id(rs.getInt("Shipment_Id"));
                shipment.setWarehouse_Id(rs.getInt("Warehouse_Id"));
                shipment.setPlace(rs.getString("Place"));
                pro.setShipment(shipment);

                pro.setProductCode(rs.getString("Product_code"));

                list.add(pro);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean updateProductInventory(int productId, int quantityToSubtract) {
        String sql = "UPDATE swp_project.product SET Inventory = Inventory - ? WHERE P_Id = ? AND Inventory >= ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, quantityToSubtract);
            st.setInt(2, productId);
            st.setInt(3, quantityToSubtract); // Ensure inventory won't go below zero
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println("Error updating product inventory: " + e.getMessage());
            return false;
        }
    }

    public List<product> listAllProducts(String search, int ware, int supplier, String sort) {
        List<product> listProduct = new ArrayList<>();
        String sql = "SELECT p.Image_Link, p.P_Id, p.Product_Name, p.Car_Id, p.Inventory, p.Supplier_Id, p.Producer_Id,p.Unit,p.Import_Price, p.Sales_Price,sh.Warehouse_Id, p.Product_code,  "
                + "c.Car_Name, s.Supplier_Name,po.Producer_Name ,w.Warehouse_Name, SH.Place, p.description, p.product_code "
                + "FROM swp_project.product p "
                + "JOIN swp_project.car c ON p.Car_Id = c.Car_Id "
                + "JOIN swp_project.supplier s ON p.Supplier_Id = s.Supplier_Id "
                + "LEFT JOIN swp_project.producer po ON p.Producer_Id = po.Producer_Id "
                + " LEFT Join swp_project.shipment as SH on SH.Shipment_Id = p.Shipment_Id "
                + "LEFT JOIN swp_project.warehouse as w ON SH.Warehouse_Id = w.Warehouse_Id "
                + "WHERE 1 = 1 ";
        if (!search.equals("")) {
            sql += " and p.Product_Name like ?";
        }
        if (ware > 0) {
            sql += " and w.Warehouse_Id =? ";
        }
        if (supplier > 0) {
            sql += " and p.Supplier_Id =? ";
        }
        if (sort.equals("1")) {
            sql += " and p.inventory > 0";
        }
        if (sort.equals("0")) {
            sql += " and p.inventory = 0";
        }
        try {
            PreparedStatement statement = con.prepareStatement(sql);
            int index = 1;
            if (!search.equals("")) {
                statement.setString(index++, "%" + search + "%");
            }
            if (ware > 0) {
                statement.setInt(index++, ware);
            }
            if (supplier > 0) {
                statement.setInt(index++, supplier);
            }
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
                pro.setDesc(rs.getString("description"));
                listProduct.add(pro);
            }
        } catch (Exception e) {
            System.out.println("Get all: " + e);
        }
        return listProduct;
    }

    public List<product> listAllProductsSortInventory(String inventory) {
        List<product> listProduct = new ArrayList<>();
        String sql = "SELECT p.Image_Link,p.P_Id, p.Product_Name, p.Car_Id, p.Inventory, p.Supplier_Id, p.Producer_Id,p.Unit,p.Import_Price, p.Sales_Price,sh.Warehouse_Id,  "
                + "c.Car_Name, s.Supplier_Name,po.Producer_Name ,w.Warehouse_Name, SH.Place, p.product_code, p.description "
                + "FROM swp_project.product p "
                + "JOIN swp_project.car c ON p.Car_Id = c.Car_Id "
                + "JOIN swp_project.supplier s ON p.Supplier_Id = s.Supplier_Id "
                + "LEFT JOIN swp_project.producer po ON p.Producer_Id = po.Producer_Id "
                + " LEFT Join swp_project.shipment as SH on SH.Shipment_Id = p.Shipment_Id "
                + "LEFT JOIN swp_project.warehouse as w ON SH.Warehouse_Id = w.Warehouse_Id "
                + "WHERE 1 = 1 ";
        if (!inventory.equals("")) {
            sql += " ORDER BY p.Inventory " + inventory;
        }
        try {
            PreparedStatement statement = con.prepareStatement(sql);
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
                pro.setDesc(rs.getString("description"));
                listProduct.add(pro);
            }
        } catch (Exception e) {
            System.out.println("Get all: " + e);
        }
        return listProduct;
    }

    public product getProduct(int id) throws SQLException {
        product pro = null;
        String sql = "SELECT p.Image_Link,p.P_Id, p.Product_Name, p.Car_Id, p.Inventory, p.Supplier_Id, p.Producer_Id,p.Unit,p.Import_Price, p.Sales_Price,sh.Warehouse_Id, p.Product_code, "
                + "c.Car_Name, s.Supplier_Name,po.Producer_Name ,w.Warehouse_Name, SH.Place, p.product_code, p.description "
                + "FROM swp_project.product p "
                + "JOIN swp_project.car c ON p.Car_Id = c.Car_Id "
                + "JOIN swp_project.supplier s ON p.Supplier_Id = s.Supplier_Id "
                + "LEFT JOIN swp_project.producer po ON p.Producer_Id = po.Producer_Id "
                + " LEFT Join swp_project.shipment as SH on SH.Shipment_Id = p.Shipment_Id "
                + "LEFT JOIN swp_project.warehouse as w ON SH.Warehouse_Id = w.Warehouse_Id "
                + "WHERE p.P_ID = ? ";
        PreparedStatement statement = con.prepareStatement(sql);
        statement.setInt(1, id);
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
            pro = new product();
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
            pro.setImage_Link(rs.getString("Image_Link"));
            pro.setPlace(rs.getString("place"));
            pro.setProductCode(rs.getString("Product_code"));
            pro.setDesc(rs.getString("description"));
        }
        return pro;
    }

    public product getProductByCode(int id, String code) throws SQLException {
        product pro = null;
        String sql = "SELECT p.Image_Link,p.P_Id, p.Product_Name, p.Car_Id, p.Inventory, p.Supplier_Id, p.Producer_Id,p.Unit,p.Import_Price, p.Sales_Price,sh.Warehouse_Id, p.Product_code, "
                + "c.Car_Name, s.Supplier_Name,po.Producer_Name ,w.Warehouse_Name, SH.Place, p.product_code, p.description "
                + "FROM swp_project.product p "
                + "JOIN swp_project.car c ON p.Car_Id = c.Car_Id "
                + "JOIN swp_project.supplier s ON p.Supplier_Id = s.Supplier_Id "
                + "LEFT JOIN swp_project.producer po ON p.Producer_Id = po.Producer_Id "
                + " LEFT Join swp_project.shipment as SH on SH.Shipment_Id = p.Shipment_Id "
                + "LEFT JOIN swp_project.warehouse as w ON SH.Warehouse_Id = w.Warehouse_Id "
                + "WHERE p.P_ID != ? and p.product_code = ?";
        PreparedStatement statement = con.prepareStatement(sql);
        statement.setInt(1, id);
        statement.setString(2, code);
        ResultSet rs = statement.executeQuery();
        if (rs.next()) {
            pro = new product();
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
            pro.setImage_Link(rs.getString("Image_Link"));
            pro.setPlace(rs.getString("place"));
            pro.setProductCode(rs.getString("Product_code"));
            pro.setDesc(rs.getString("description"));
        }
        return pro;
    }

    public int editProduct(product p) {
        String sql = "UPDATE product SET Import_Price = ?, Sales_Price = ?, Supplier_Id = ?, Car_Id=?,Product_Name=?, unit=?, Image_Link=?, product_code=?, description=? WHERE P_Id = ?";

        try {
            PreparedStatement statement = con.prepareStatement(sql);
            int i = 1;
            statement.setDouble(i++, p.getImport_price());
            statement.setDouble(i++, p.getSale_price());
            statement.setInt(i++, p.getSupplier_id().getSupplierId());
            statement.setInt(i++, p.getCar_id().getCarId());
            statement.setString(i++, p.getProduct_name());
            statement.setString(i++, p.getUnit());
            statement.setString(i++, p.getImage_Link());
            statement.setString(i++, p.getProductCode());
            statement.setString(i++, p.getDesc());
            statement.setInt(i++, p.getP_id());
            return statement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Edit fail: " + e);
        }
        return 0;
    }

    public int moveProduct(int p_id, int shipment_id) {
        String sql = "INSERT INTO swp_project.freight (P_Id, id_ShipmentNew, status_product,checked )\n" +
                "VALUES (?, ?, 'NOT','NOT');";

        try {
            PreparedStatement statement = con.prepareStatement(sql);

           statement.setInt(1,p_id);
           statement.setInt(2,shipment_id);
            return statement.executeUpdate();
        } catch (Exception e) {
            System.out.println("Edit fail: " + e);
        }
        return 0;
    }



    public boolean addProduct(product product) {
        String sql = "INSERT INTO product (Product_Name, Car_Id, unit, Supplier_Id, Import_Price, Sales_Price, Producer_Id, inventory, Image_Link, product_code, description) VALUES (?, ?, ?, ?, ?, ?, ?, 0, ?, ?,?)";
        try {
            PreparedStatement stmt = con.prepareStatement(sql);
            int i = 1;
            stmt.setString(i++, product.getProduct_name());
            stmt.setInt(i++, product.getCar_id().getCarId());
            stmt.setString(i++, product.getUnit());
            stmt.setInt(i++, product.getSupplier_id().getSupplierId());
            stmt.setDouble(i++, product.getImport_price());
            stmt.setDouble(i++, product.getSale_price());
            stmt.setInt(i++, product.getProducer());
            stmt.setString(i++, product.getImage_Link());
            stmt.setString(i++, product.getProductCode());
            stmt.setString(i++, product.getDesc());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một hàng được thêm vào CSDL
        } catch (SQLException e) {
            System.out.println("Add new: " + e);
            return false; // Trả về false nếu có lỗi xảy ra
        }
    }

    public void importProduct(int P_id, int quantity, int ship_id) {
        String sql = "UPDATE swp_project.product p SET p.Inventory = p.Inventory + ?, p.Shipment_Id = ? WHERE P_id = ?";
        try {
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setInt(3, P_id);
            statement.setInt(1, quantity);
            statement.setInt(2, ship_id);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public void reImportProduct(int P_id, int quantity) {
        String sql = "UPDATE swp_project.product p SET p.Inventory = p.Inventory - ?, p.Shipment_Id = NULL WHERE P_id = ?";
        try {
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setInt(2, P_id);
            statement.setInt(1, quantity);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public void exportProduct(int P_id, int quantity) {
        String sql = "UPDATE swp_project.product p SET p.Inventory = p.Inventory - ? WHERE P_id = ?";
        try {
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setInt(2, P_id);
            statement.setInt(1, quantity);


            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public void reExportProduct(int P_id, int quantity) {
        String sql = "UPDATE swp_project.product p SET p.Inventory = p.Inventory + ? WHERE P_id = ?";
        try {
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setInt(2, P_id);
            statement.setInt(1, quantity);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);

        }
    }

    public static void main(String[] args) throws SQLException {
        ProductDao productDao = new ProductDao();
    //    productDao.moveProduct(, 2);

    }
}
