package com.example.qlkh.DAO;

import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Supplier;

import com.example.qlkh.model.Suppliers;

public class SupplierDAO extends DAO {

    // Lấy danh sách nhà cung cấp
    public List<Suppliers> getAllSuppliers() {
        List<Suppliers> supplier = new ArrayList<>();
        String sql = "select * from supplier";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Suppliers s = new Suppliers();
                s.setSupplierId(rs.getInt("Supplier_Id"));
                s.setSupplierName(rs.getString("Supplier_Name"));
                s.setSupplierPhone(rs.getString("Phone"));
                s.setSupplierAddress(rs.getString("Supplier_Address"));
                s.setDebt( rs.getDouble("Debt"));
                s.setTax(rs.getString("Tax_code"));
                supplier.add(s);
            }
        }catch (SQLException e) {
            System.out.println(e);
        }
        return supplier;
    }

    public List<Suppliers> getDebtSuppliers() {
        List<Suppliers> supplier = new ArrayList<>();
        String sql = "select * from supplier where Debt >0";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Suppliers s = new Suppliers();
                s.setSupplierId(rs.getInt("Supplier_Id"));
                s.setSupplierName(rs.getString("Supplier_Name"));
                s.setSupplierPhone(rs.getString("Phone"));
                s.setSupplierAddress(rs.getString("Supplier_Address"));
                s.setDebt(rs.getDouble("Debt"));
                s.setTax(rs.getString("Tax_code"));
                supplier.add(s);
            }
        }catch (SQLException e) {
            System.out.println(e);
        }
        return supplier;
    }

    // thêm nhà cung cấp mới
    public boolean addSupplier(Suppliers supplier) {
        String sql = "INSERT INTO supplier (Supplier_Name, Phone, Supplier_Address,Debt,Tax_code) VALUES (?, ?, ?,0,?)";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, supplier.getSupplierName());
            st.setString(2, supplier.getSupplierPhone());
            st.setString(3, supplier.getSupplierAddress());
            st.setString(4, supplier.getTax());
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    // update thông tin nhà cung cấp
    public boolean updateSupplier(Suppliers supplier) {
        String sql = "UPDATE supplier SET Supplier_Name = ?, Phone = ?, Supplier_Address = ? , Tax_code=? WHERE Supplier_Id = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, supplier.getSupplierName());
            st.setString(2, supplier.getSupplierPhone());
            st.setString(3, supplier.getSupplierAddress());
            st.setString(4, supplier.getTax());
            st.setInt(5, supplier.getSupplierId()); // Thêm Supplier_Id vào câu lệnh SQL
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    // tìm kiếm nhà cung cấp qua id
    public Suppliers getSupplier(int id) {
        Suppliers supplier = null;
        String sql = "SELECT * FROM supplier WHERE Supplier_Id = ?";
        try {
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                String supplierName = resultSet.getString("Supplier_Name");
                String phone = resultSet.getString("Phone");
                String supplierAddress = resultSet.getString("Supplier_Address");
                double debt = resultSet.getDouble("Debt");
                String tax = resultSet.getString("Tax_code");
                supplier = new Suppliers();
                supplier.setSupplierId(id);
                supplier.setSupplierName(supplierName);
                supplier.setSupplierPhone(phone);
                supplier.setSupplierAddress(supplierAddress);
                supplier.setTax(tax);
                supplier.setDebt(debt);
            }
            return supplier;
        } catch (Exception e) {
            System.out.println("Get supplier by id: " + e);
        }
        return null;
    }

    public Suppliers getSupplierById(int supplierId) {
        String sql = "SELECT * FROM supplier WHERE Supplier_Id = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, supplierId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Suppliers supplier = new Suppliers();
                supplier.setSupplierId(rs.getInt("Supplier_Id"));
                supplier.setSupplierName(rs.getString("Supplier_Name"));
                supplier.setSupplierPhone(rs.getString("Phone"));
                supplier.setSupplierAddress(rs.getString("Supplier_Address"));
                supplier.setDebt(rs.getDouble("Debt"));
                supplier.setTax(rs.getString("Tax_code"));
                return supplier;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    // Xóa nhà cung cấp
    public boolean deleteSupplier(int supplierId) {
        String sql = "DELETE FROM supplier WHERE Supplier_Id = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, supplierId);
            int rowsAffected = st.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }


    public boolean isSupplierExists( String phone, String supplierAddress) {
        String sql = "SELECT * FROM supplier WHERE Phone = ? OR Supplier_Address = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, phone);
            st.setString(2, supplierAddress);
            ResultSet rs = st.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public List<Suppliers> getAllSupplier() {
        List<Suppliers> supplierList = new ArrayList<>();

        String sql = "SELECT * FROM supplier";
        try {
            PreparedStatement statement = con.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Suppliers supplier = null;
                int id = resultSet.getInt("Supplier_id");
                String supplierName = resultSet.getString("Supplier_Name");
                String phone = resultSet.getString("Phone");
                String supplierAddress = resultSet.getString("Supplier_Address");
                double Debt = resultSet.getDouble("Debt");
                String tax = resultSet.getString("Tax_code");
                supplier = new Suppliers();
                supplier.setSupplierId(id);
                supplier.setSupplierName(supplierName);
                supplier.setSupplierPhone(phone);
                supplier.setSupplierAddress(supplierAddress);
                supplier.setDebt(Debt);
                supplier.setTax(tax);
                supplierList.add(supplier);
            }
        } catch (Exception e) {
            System.out.println("Get supplier by id: " + e);
        }
        return supplierList;
    }
    //Check thông tin supplier
    public List<Suppliers> searchSuppliers(String ten, String phone, String mst) {
        List<Suppliers> supplier = new ArrayList<>();
        String sql = "select * from supplier s where " +
                "(? is null or s.Supplier_Name like ? ) and " +
                "(? is null or s.Phone like ? ) and " +
                "(? is null or s.Tax_code like ? ) and Debt>0";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, ten);
            st.setString(2, "%"+ten+"%");
            st.setString(3, phone);
            st.setString(4, "%"+phone+"%");
            st.setString(5, mst);
            st.setString(6, "%"+mst+"%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Suppliers s = new Suppliers();
                s.setSupplierId(rs.getInt("Supplier_Id"));
                s.setSupplierName(rs.getString("Supplier_Name"));
                s.setSupplierPhone(rs.getString("Phone"));
                s.setSupplierAddress(rs.getString("Supplier_Address"));
                s.setDebt(rs.getDouble("Debt"));
                s.setTax(rs.getString("Tax_code"));
                supplier.add(s);
            }
        }catch (SQLException e) {
            System.out.println(e);
        }
        return supplier;
    }

    public void debtSupplier(int sup_id, double total) {
        String sql = "UPDATE swp_project.supplier s SET s.Debt = s.Debt + ? WHERE s.Supplier_Id = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(2, sup_id);
            st.setDouble(1, total);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void reDebtSupplier(int sup_id, double total) {
        String sql = "UPDATE swp_project.supplier s SET s.Debt = s.Debt - ? WHERE s.Supplier_Id = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(2, sup_id);
            st.setDouble(1, total);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public boolean addAllSupplier(List<Suppliers> suppliers) {
        boolean check = true;
        String sql = "INSERT INTO supplier (Supplier_Name, Phone, Supplier_Address,Debt,Tax_code) VALUES (?, ?, ?,0,?)";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            for(Suppliers suppliers1 : suppliers){
                st.setString(1, suppliers1.getSupplierName());
                st.setString(2, suppliers1.getSupplierPhone());
                st.setString(3, suppliers1.getSupplierAddress());
                st.setString(4, suppliers1.getTax());
                st.addBatch();
            }
          st.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
            check = false;
        }
        return check;
    }

    public static void main(String[] args) {
        Suppliers supplierTest = new Suppliers();
        SupplierDAO supplierDAO = new SupplierDAO();
        List<Suppliers> suppliers = supplierDAO.getAllSuppliers();
        for (Suppliers supplier : suppliers) {
            System.out.println(supplier);
        }
        supplierDAO.debtSupplier(1, 100);
    }

}
