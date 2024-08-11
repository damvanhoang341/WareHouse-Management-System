package com.example.qlkh.DAO;

import com.example.qlkh.model.PhieuThuNo;
import com.example.qlkh.model.RepaymentSlip;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RepaymentSlipDAO extends DAO{
    //insnsert replayment slip in Database
    public boolean addReplayment(RepaymentSlip rep) {
        String insertSql = "INSERT INTO debt_payment (Supplier_id, paid, Dates, employees_id, payment_method, description) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        String updateSql = "UPDATE supplier SET Debt = Debt - ? WHERE Supplier_id = ?";

        try {
            // Insert into debt_payment table
            PreparedStatement insertStmt = con.prepareStatement(insertSql,Statement.RETURN_GENERATED_KEYS);
            insertStmt.setInt(1, rep.getSupplierId());
            insertStmt.setDouble(2, rep.getAmountMoney());
            insertStmt.setDate(3, new java.sql.Date(rep.getDate().getTime())); // Assuming rep.getDate() returns java.util.Date
            insertStmt.setInt(4, rep.getEmployee());
            insertStmt.setString(5, rep.getMethodPay());
            insertStmt.setString(6, rep.getReason());

            int rowsInserted = insertStmt.executeUpdate();
            if (rowsInserted > 0) {
                ResultSet generatedKeys = insertStmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int id = generatedKeys.getInt(1); // Retrieve generated key if needed
                }
            } else {
                return false;
            }

            // Update supplier table
            PreparedStatement updateStmt = con.prepareStatement(updateSql);
            updateStmt.setDouble(1, rep.getAmountMoney());
            updateStmt.setInt(2, rep.getSupplierId());
            double amount = rep.getAmountMoney();
            updateOrInsertRevenue(new java.sql.Date(rep.getDate().getTime()),amount);
            int rowsUpdated = updateStmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public void updateOrInsertRevenue(java.util.Date date, double amount) throws SQLException {
        // Kiểm tra nếu ngày đã tồn tại trong bảng revenue
        String selectSql = "SELECT * FROM revenue WHERE Dates = ?";
        PreparedStatement selectStmt = con.prepareStatement(selectSql);
        selectStmt.setDate(1, new java.sql.Date(date.getTime()));
        ResultSet rs = selectStmt.executeQuery();

        if (rs.next()) {
            // Ngày đã tồn tại, cộng thêm số tiền vào cột Revenue_money
            String updateSql = "UPDATE revenue SET Revenue_money = Revenue_money - ? WHERE Dates = ?";
            PreparedStatement updateStmt = con.prepareStatement(updateSql);
            updateStmt.setDouble(1, amount);
            updateStmt.setDate(2, new java.sql.Date(date.getTime()));
            updateStmt.executeUpdate();
            updateStmt.close();
        } else {
            // Ngày không tồn tại, tạo một hàng mới
            String insertSql = "INSERT INTO revenue (Dates, Revenue_money) VALUES (?, ?)";
            PreparedStatement insertStmt = con.prepareStatement(insertSql);
            insertStmt.setDate(1, new java.sql.Date(date.getTime()));
            insertStmt.setDouble(2, -amount);
            insertStmt.executeUpdate();
            insertStmt.close();
        }

        rs.close();
        selectStmt.close();
    }

    public RepaymentSlip getRepaymentSlipById(String id) {
        String sql = "SELECT dp.id, dp.Dates, dp.payment_method, dp.description, s.Supplier_Id, s.Supplier_Name, a.Account_Id, a.Staff_Name, dp.paid, dp.booking_code " +
                "FROM swp_project.debt_payment dp " +
                "JOIN supplier s ON dp.Supplier_id = s.Supplier_Id " +
                "JOIN account a ON dp.employees_id = a.Account_Id " +
                "WHERE dp.booking_code = ?";
        RepaymentSlip repaymentSlip = null;
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
                if (rs.next()) {
                    repaymentSlip = new RepaymentSlip();
                    repaymentSlip.setCode(rs.getString("booking_code"));
                    repaymentSlip.setId(rs.getInt("id"));
                    repaymentSlip.setDate(rs.getDate("Dates"));
                    repaymentSlip.setReason(rs.getString("description"));
                    repaymentSlip.setAmountMoney(rs.getDouble("paid"));
                    repaymentSlip.setMethodPay(rs.getString("payment_method"));
                    repaymentSlip.setEmployee(rs.getInt("Account_Id"));
                    repaymentSlip.setEmployeeName(rs.getString("Staff_Name"));
                    repaymentSlip.setSupplierId(rs.getInt("Supplier_Id"));
                    repaymentSlip.setSupplierName(rs.getString("Supplier_Name"));
                }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return repaymentSlip;
    }

    //tra danh sach
    public List<RepaymentSlip> repaymentSlipList() {
        List<RepaymentSlip>list = new ArrayList<>();
        String sql = "SELECT dp.id, dp.Dates, dp.payment_method, dp.description, s.Supplier_Id, s.Supplier_Name, a.Account_Id, a.Staff_Name, dp.paid, dp.booking_code FROM swp_project.debt_payment dp"
                + " JOIN supplier s ON dp.Supplier_id = s.Supplier_Id"
                + " JOIN account a ON dp.employees_id = a.Account_Id";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                RepaymentSlip rep = new RepaymentSlip();
                rep.setCode(rs.getString("booking_code"));
                rep.setId(rs.getInt("id"));
                rep.setDate(rs.getDate("Dates"));
                rep.setReason(rs.getString("description"));
                rep.setAmountMoney(rs.getDouble("paid"));
                rep.setMethodPay(rs.getString("payment_method"));
                rep.setEmployee(rs.getInt("Account_Id"));
                rep.setEmployeeName(rs.getString("Staff_Name"));
                rep.setSupplierId(rs.getInt("Supplier_Id"));
                rep.setSupplierName(rs.getString("Supplier_Name"));
                list.add(rep);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    public static void main(String[] args) {
        RepaymentSlip rep = new RepaymentSlip();
        rep.setSupplierId(1); // Replace with actual supplier ID
        rep.setAmountMoney(500.0); // Replace with actual amount
        rep.setDate(new Date(2024,07,15)); // Replace with actual date
        rep.setEmployee(1); // Replace with actual employee ID
        rep.setMethodPay("Tiền mặt"); // Replace with actual payment method
        rep.setReason("Payment for goods"); // Replace with actual reason

        RepaymentSlipDAO dao = new RepaymentSlipDAO();
        boolean result = dao.addReplayment(rep);

        if (result) {
            System.out.println("Repayment slip added and supplier debt updated successfully.");
        } else {
            System.out.println("Failed to add repayment slip or update supplier debt.");
        }
    }
}
