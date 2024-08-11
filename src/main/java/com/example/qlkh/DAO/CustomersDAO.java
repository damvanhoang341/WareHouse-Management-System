package com.example.qlkh.DAO;

import com.example.qlkh.model.CustomerType;
import com.example.qlkh.model.Customers;
import com.example.qlkh.model.PhieuThuNo;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomersDAO extends DAO {

    //Loại khách hàng
    public List<CustomerType> getAllType() {
        List<CustomerType> ct = new ArrayList<>();
        String sql = "select Type_Id,Type_Names,Payment_Discount from swp_project.customer_type";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                CustomerType customerType = new CustomerType();
                customerType.setCustomerTypeId(rs.getInt("Type_Id"));
                customerType.setCustomerTypeName(rs.getString("Type_Names"));
                customerType.setDiscount(rs.getDouble("Payment_Discount"));
                ct.add(customerType);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return ct;
    }

    //Danh sách khách hàng
    public List<Customers> getAllCustomers() {
        List<Customers> customers = new ArrayList<>();
        String sql = "select c.Customer_Id,ct.Type_Id,ct.Type_Names,c.Customer_Name,c.Customer_Phone,c.Customer_Address,c.Customer_Tax , ct.Payment_Discount from customer c "
                + "JOIN customer_type ct ON c.Type_Id = ct.Type_Id";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomerId(rs.getInt("Customer_Id"));
                c.setCustomerName(rs.getString("Customer_Name"));
                c.setCustomerPhone(rs.getString("Customer_Phone"));
                CustomerType ct = new CustomerType();
                ct.setCustomerTypeId(rs.getInt("Type_Id"));
                ct.setCustomerTypeName(rs.getString("Type_Names"));
                ct.setDiscount(rs.getDouble("Payment_Discount"));
                c.setCt_Id(ct);
                c.setCustomerAddress(rs.getString("Customer_Address"));
                c.setCustomerTax(rs.getString("Customer_Tax"));
                customers.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public List<Customers> getDebtCustomers() {
        List<Customers> customers = new ArrayList<>();
        String sql = "select c.Customer_Id,ct.Type_Id,ct.Type_Names,c.Customer_Name,c.Customer_Phone,c.Customer_Address,c.Customer_Tax , ct.Payment_Discount , c.Customer_Debt from customer c  "
                + "JOIN customer_type ct ON c.Type_Id = ct.Type_Id where c.Customer_Debt>0";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Customers c = new Customers();
                c.setCustomerId(rs.getInt("Customer_Id"));
                c.setCustomerName(rs.getString("Customer_Name"));
                c.setCustomerPhone(rs.getString("Customer_Phone"));
                CustomerType ct = new CustomerType();
                ct.setCustomerTypeId(rs.getInt("Type_Id"));
                ct.setCustomerTypeName(rs.getString("Type_Names"));
                ct.setDiscount(rs.getDouble("Payment_Discount"));
                c.setCt_Id(ct);
                c.setCustomerAddress(rs.getString("Customer_Address"));
                c.setCustomerTax(rs.getString("Customer_Tax"));
                c.setCustomerDebt(rs.getDouble("Customer_Debt"));
                customers.add(c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public boolean updateCustomerDebt(int customerId, double amountToAdd) {
        String sql = "UPDATE customer SET Customer_Debt = Customer_Debt + ? WHERE Customer_Id = ?";
        try (PreparedStatement st = con.prepareStatement(sql)) {
            st.setDouble(1, amountToAdd);
            st.setInt(2, customerId);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    // thêm khách hàng mới
    public boolean addCustomer(Customers customer) {
        String sql = "INSERT INTO customer (Type_Id, Customer_Name, Customer_Phone,Customer_Address,Customer_Tax,Customer_Debt) VALUES (?, ?, ?,?,?,0)";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, customer.getCt_Id().getCustomerTypeId());
            st.setString(2, customer.getCustomerName());
            st.setString(3, customer.getCustomerPhone());
            st.setString(4,customer.getCustomerAddress());
            st.setString(5,customer.getCustomerTax());
            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean addAllCustomer(List<Customers> customers) {
        boolean check = true;
        String sql = "INSERT INTO customer (Type_Id, Customer_Name, Customer_Phone,Customer_Address,Customer_Tax,Customer_Debt) VALUES (?, ?, ?,?,?,0)";

        try {
            PreparedStatement st = con.prepareStatement(sql);
            for(Customers customers1 : customers){
                st.setInt(1, customers1.getCt_Id().getCustomerTypeId());
                st.setString(2, customers1.getCustomerName());
                st.setString(3, customers1.getCustomerPhone());
                st.setString(4,customers1.getCustomerAddress());
                st.setString(5,customers1.getCustomerTax());
                st.addBatch();
            }

            st.executeBatch();
        } catch (SQLException e) {
            e.printStackTrace();
            check = false;
        }
        return check;
    }

    // cập nhật mức chiết khấu
    public boolean updatePaymentDiscount(int customerTypeId, double newDiscount) {
        String sql = "UPDATE customer_type SET Payment_Discount = ? WHERE Type_Id = ?";
        try (PreparedStatement st = con.prepareStatement(sql)) {
            st.setDouble(1, newDiscount);
            st.setInt(2, customerTypeId);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Tìm kiếm khách hàng qua id
    public Customers getCustomerById(int customerId) {
        Customers customer = null;
        String sql = "SELECT c.Customer_Id, ct.Type_Id, ct.Type_Names, c.Customer_Name, c.Customer_Phone, ct.Payment_Discount ,c.Customer_Address,c.Customer_Tax , c.Customer_Debt " +
                "FROM customer c JOIN customer_type ct ON c.Type_Id = ct.Type_Id WHERE c.Customer_Id = ?";
        try (PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, customerId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                customer = new Customers();
                customer.setCustomerId(rs.getInt("Customer_Id"));
                customer.setCustomerName(rs.getString("Customer_Name"));
                customer.setCustomerPhone(rs.getString("Customer_Phone"));
                customer.setCustomerAddress(rs.getString("Customer_Address"));
                customer.setCustomerTax(rs.getString("Customer_Tax"));
                CustomerType ct = new CustomerType();
                ct.setCustomerTypeId(rs.getInt("Type_Id"));
                ct.setCustomerTypeName(rs.getString("Type_Names"));
                ct.setDiscount(rs.getDouble("Payment_Discount"));
                customer.setCustomerDebt(rs.getDouble("Customer_Debt"));
                customer.setCt_Id(ct);

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    //Update thông tin khách hàng
    public boolean updateCustomer(Customers customer) {
        String sql = "UPDATE customer SET Type_Id = ?, Customer_Name = ?, Customer_Phone = ?, Customer_Address = ?, Customer_Tax = ? WHERE Customer_Id = ?";
        try (PreparedStatement st = con.prepareStatement(sql)) {
            st.setInt(1, customer.getCt_Id().getCustomerTypeId());
            st.setString(2, customer.getCustomerName());
            st.setString(3, customer.getCustomerPhone());
            st.setString(4, customer.getCustomerAddress());
            st.setString(5, customer.getCustomerTax());
            st.setInt(6, customer.getCustomerId());
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    // Kiểm tra khách hàng qua số điện thoại
    public boolean checkCustomerPhoneExists(String customerPhone) {
        String sql = "SELECT COUNT(*) FROM customer WHERE Customer_Phone = ?";
        try (PreparedStatement st = con.prepareStatement(sql)) {
            st.setString(1, customerPhone);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    //Test
    public static void main(String[] args) {
        CustomersDAO customersDAO = new CustomersDAO();

        // Test getAllType method
        /*System.out.println("Testing getAllType method:");
        List<CustomerType> customerTypes = customersDAO.getAllType();
        for (CustomerType ct : customerTypes) {
            System.out.println("Customer Type ID: " + ct.getCustomerTypeId());
            System.out.println("Customer Type Name: " + ct.getCustomerTypeName());
            System.out.println("Discount: " + ct.getDiscount());
            System.out.println();
        }

        // Test getAllCustomers method
        System.out.println("Testing getAllCustomers method:");
        List<Customers> customersList = customersDAO.getAllCustomers();
        for (Customers customer : customersList) {
            System.out.println("Customer ID: " + customer.getCustomerId());
            System.out.println("Customer Name: " + customer.getCustomerName());
            System.out.println("Customer Phone: " + customer.getCustomerPhone());
            CustomerType ct = customer.getCt_Id();
            System.out.println("Customer Type ID: " + ct.getCustomerTypeId());
            System.out.println("Customer Type Name: " + ct.getCustomerTypeName());
            System.out.println("Discount: " + ct.getDiscount());
            System.out.println();
        }*/
        System.out.println("Testing getCustomerById method:");
        Customers customer = customersDAO.getCustomerById(1);
        if (customer != null) {
            System.out.println("Customer ID: " + customer.getCustomerId());
            System.out.println("Customer Name: " + customer.getCustomerName());
            System.out.println("Customer Phone: " + customer.getCustomerPhone());
            CustomerType ct = customer.getCt_Id();
            System.out.println("Customer Type ID: " + ct.getCustomerTypeId());
            System.out.println("Customer Type Name: " + ct.getCustomerTypeName());
            System.out.println("Discount: " + ct.getDiscount());
            System.out.println("Customer address: " + customer.getCustomerAddress());
            System.out.println("Customer Tax: " + customer.getCustomerTax());
            System.out.println();
        } else {
            System.out.println("Customer not found!");
        }
        List<Customers> c =  customersDAO.getDebtCustomers();
        System.out.println(c);
    }
}
