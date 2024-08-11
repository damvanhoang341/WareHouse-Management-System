package com.example.qlkh.DAO;
import com.example.qlkh.model.Revenue;
import com.example.qlkh.model.collectionDebt;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DebtDAO extends DAO{
    public List<Revenue> getRevenueByMonth(int month, int year) {
        List<Revenue> revenueRecords = new ArrayList<>();
        String sql = "SELECT * FROM revenue WHERE MONTH(Dates) = ? AND YEAR(Dates) = ?";

        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, month);
            st.setInt(2, year);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Revenue record = new Revenue();
                record.setDate(rs.getDate("Dates"));
                record.setMoney(rs.getDouble("Revenue_money"));
                revenueRecords.add(record);
            }

            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return revenueRecords;
    }
    public double getTotalRevenueByMonth(int month, int year) {
        String sql = "SELECT SUM(Revenue_money) AS totalRevenue FROM revenue WHERE MONTH(Dates) = ? AND YEAR(Dates) = ?";
        double totalRevenue = 0;

        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, month);
            st.setInt(2, year);

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                totalRevenue = rs.getDouble("totalRevenue");
            }

            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalRevenue;
    }

    public boolean addDebtCollection(collectionDebt c) {
        String sql = "INSERT INTO debt_collection (customer_id, employee_id, so_tien, Dates, Descriptions, Pay_method) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setInt(1, c.getCustomerId());
            st.setInt(2, c.getEmployeesId());
            st.setDouble(3, c.getMoney());
            st.setDate(4, new java.sql.Date(c.getDate().getTime()));
            st.setString(5, c.getDescription());
            st.setString(6, c.getPayment_method());

            int rowsInserted = st.executeUpdate();
            if (rowsInserted > 0) {
                // Lấy id của bản ghi vừa được thêm vào debt_collection
                ResultSet generatedKeys = st.getGeneratedKeys();
                int debtCollectionId = -1;
                if (generatedKeys.next()) {
                    debtCollectionId = generatedKeys.getInt(1);
                }
                generatedKeys.close();

                // Trừ số tiền vào cột Customer_Debt của bảng customer
                if (debtCollectionId != -1) {
                    double amount = c.getMoney();
                    updateCustomerDebt(c.getCustomerId(), amount);
                    updateOrInsertRevenue(new java.sql.Date(c.getDate().getTime()), amount);
                }
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
        return false;
    }
    private void updateCustomerDebt(int customerId, double amount) throws SQLException {
        String updateSql = "UPDATE customer SET Customer_Debt = Customer_Debt - ? WHERE Customer_Id = ?";
        PreparedStatement updateStmt = con.prepareStatement(updateSql);
        updateStmt.setDouble(1, amount);
        updateStmt.setInt(2, customerId);
        updateStmt.executeUpdate();
        updateStmt.close();
    }

    public void updateOrInsertRevenue(Date date, double amount) throws SQLException {
        // Kiểm tra nếu ngày đã tồn tại trong bảng revenue
        String selectSql = "SELECT * FROM revenue WHERE Dates = ?";
        PreparedStatement selectStmt = con.prepareStatement(selectSql);
        selectStmt.setDate(1, new java.sql.Date(date.getTime()));
        ResultSet rs = selectStmt.executeQuery();

        if (rs.next()) {
            // Ngày đã tồn tại, cộng thêm số tiền vào cột Revenue_money
            String updateSql = "UPDATE revenue SET Revenue_money = Revenue_money + ? WHERE Dates = ?";
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
            insertStmt.setDouble(2, amount);
            insertStmt.executeUpdate();
            insertStmt.close();
        }

        rs.close();
        selectStmt.close();
    }

    public void changeDebt(int OutputId, double debt) {
        String sql = "UPDATE swp_project.debt d SET d.Debt = d.Debt + ? WHERE d.Output_Id = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setDouble(1, debt);  // Set the first parameter
            st.setInt(2, OutputId); // Set the second parameter

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }


    public void reChangeDebt(int OutputId, double debt) {
        String sql = "UPDATE swp_project.debt d SET d.Debt = d.Debt - ? WHERE d.Output_Id = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setDouble(1, debt);
            st.setInt(2, OutputId);

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }



    public static void main(String[] args) {
        DebtDAO dao = new DebtDAO(); // Chú ý: đây là giả sử DebtDAO có constructor nhận Connection
       dao.reChangeDebt(1,10000);
    }


}
