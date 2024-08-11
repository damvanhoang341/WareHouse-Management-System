package com.example.qlkh.DAO;


import com.example.qlkh.model.*;


import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Supplier;

public class ImportDAO extends DAO{

    public ArrayList<Import> getProduct(){
        ArrayList<Import> export = new ArrayList<>();

        String sql = "SELECT p.*, c.*, sup.*, s.place FROM swp_project.product p " +
                "LEFT JOIN swp_project.car c ON p.Car_Id = c.Car_Id " +
                "LEFT JOIN swp_project.supplier sup ON p.Supplier_Id = sup.Supplier_Id " +
                "LEFT JOIN swp_project.shipment s ON p.Shipment_Id = s.Shipment_Id ";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Import e = new Import();
                Suppliers p = new Suppliers();
                p.setSupplierId(rs.getInt("Supplier_Id"));
                p.setSupplierName(rs.getString("Supplier_Name"));
                e.setSupplier(p);
                e.setP_id(rs.getInt("P_Id"));
                e.setProduct_name(rs.getString("Product_Name"));
                e.setCar_name(rs.getString("Car_Name"));
                e.setInventory(rs.getInt("Inventory"));
                //e.setPlace(rs.getString("Place"));
                //e.setSub_place(rs.getString("Place"));
                e.setUnit(rs.getString("Unit"));
                e.setPrice(rs.getFloat("Import_Price"));
                e.setSale_price(rs.getFloat("Sales_Price"));
                export.add(e);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return export;
    }

    public int numberImports() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM swp_project.import WHERE Check_Status LIKE ?";
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = con.prepareStatement(sql);
            ps.setString(1, "%Đã duyệt%");
            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return count;
    }


    public ArrayList<ListImport> getListImport(){
        ArrayList<ListImport> list = new ArrayList<>();

        String sql = "SELECT * FROM swp_project.import i left join swp_project.account a on i.Account_Id = a.Account_Id left join swp_project.warehouse w on i.Warehouse_Id = w.Warehouse_Id order by i.Input_Date DESC ";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ListImport li = new ListImport();
                li.setImport_Id(rs.getInt("Import_Id"));
                li.setInput_Amount(rs.getInt("Input_Amount"));
                li.setDebt(rs.getInt("Debt"));
                li.setInput_Date(rs.getDate("Input_Date"));
                User u = new User();
                u.setId(rs.getInt("Account_Id"));
                u.setName(rs.getString("Staff_Name"));
                li.setAcc(u);
                li.setCheck_Status(rs.getString("Check_Status"));
                li.setProblem(rs.getString("Problem"));
                li.setEnvident(rs.getString("Envident"));
                WareHouse ware = new WareHouse();
                ware.setId(rs.getInt("Warehouse_Id"));
                ware.setName(rs.getString("Warehouse_Name"));
                li.setWareHouse(ware);

                li.setAddedImport(rs.getString("AddedImport"));
                list.add(li);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void addNewImport(String orderCode, double total, double debt, Date date, int idAccount,String note, String fileLink, int warehouseId){


        try {
            String sql = "INSERT INTO swp_project.import (Import_Id, Input_Amount, Debt, Input_Date,Account_Id , Check_Status, Problem, Envident, Warehouse_Id, AddedImport  ) VALUES ( ?,?, ?, ?, ?, 'Chờ duyệt', ?, ?,? ,'NOT');";
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setString(1, orderCode);
            statement.setDouble(2, total);
            statement.setDouble(3, debt);
            statement.setDate(4, date);
            statement.setInt(5, idAccount);
            statement.setString(6, note);
            statement.setString(7, fileLink);
            statement.setInt(8, warehouseId);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addProdImport(String code, int P_id, int quantity, double sumProduct){


        try {
            String sql = "INSERT INTO swp_project.import_detail (Import_Id,P_ID, import_quantity, product_total ) VALUES (?, ?, ?,?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, code);
            statement.setInt(2, P_id);
            statement.setDouble(3, quantity);
            statement.setDouble(4, sumProduct);
            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void ChangeAddedImport(String status, int id ){


        try {
            String sql = "UPDATE swp_project.import i SET i.AddedImport = ? WHERE i.Import_Id = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, id);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void ChangeStatusImport(String status, int id ){


        try {
            String sql = "UPDATE swp_project.import i SET i.Check_Status = ? WHERE i.Import_Id = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, id);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        ImportDAO importDAO = new ImportDAO();
        ArrayList<Import> products = importDAO.getProduct();

        // In kết quả ra màn hình
        for (Import product : products) {
            System.out.println("Product ID: " + product.getP_id());
            System.out.println("Product Name: " + product.getProduct_name());
            System.out.println("Supplier Name: " + product.getSupplier().getSupplierName());
            System.out.println("Car Name: " + product.getCar_name());
            System.out.println("Inventory: " + product.getInventory());
            System.out.println("Place: " + String.join(", ", product.getPlace()));
            System.out.println("Sub Place: " + String.join(", ", product.getSub_place()));
            System.out.println("Unit: " + product.getUnit());
            System.out.println("Import Price: " + product.getPrice());
            System.out.println("Sales Price: " + product.getSale_price());
            System.out.println("----------------------------------------");
        }


    }
}
