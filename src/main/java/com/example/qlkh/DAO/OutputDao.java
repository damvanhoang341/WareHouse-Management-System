package com.example.qlkh.DAO;

import com.example.qlkh.dto.DebtCollectionDTO;
import com.example.qlkh.model.Export;
import com.example.qlkh.model.Suppliers;
import com.example.qlkh.model.output;

import java.math.BigDecimal;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
public class OutputDao extends DAO {
    //tien kiem duoc hàng ngay table output_order
    public double getDailyIncome(Date date) {
        double totalIncome = 0.0;
        String sql = "SELECT SUM(Paid) AS TotalIncome FROM output_order WHERE Output_Date = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(date.getTime())); // Chuyển đổi java.util.Date thành java.sql.Date
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalIncome = rs.getDouble("TotalIncome");
            }

            rs.close();
            ps.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return totalIncome;
    }

    //so luong mat hang ban ra trong ngay table output_orderDetail
    public int getQuanlityProducts(Date date) {
        int totalProduct = 0;
        String sql = "SELECT SUM(od.Output_Quantity) AS TotalQuantitySold " +
                "FROM output_detail od " +
                "JOIN output_order oo ON od.Output_Id = oo.Output_Id " +
                "WHERE oo.Output_Date = ?";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            // Chuyển đổi java.util.Date thành java.sql.Date
            ps.setDate(1, new java.sql.Date(date.getTime()));
            //ps.setDate(1, (java.sql.Date) date);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                totalProduct = rs.getInt("TotalQuantitySold");
            }

            rs.close();
            ps.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return totalProduct;
    }

    public int countOutputDetailsByDate(Date date) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS CountOutputDetails " +
                "FROM output_order od " +
                "WHERE od.Output_Date = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(date.getTime()));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("CountOutputDetails");
            }

            rs.close();
            ps.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return count;
    }

    public List<DebtCollectionDTO> getAllDebtCollection(){
        List<DebtCollectionDTO> list = new ArrayList<>();
        String sql = "select Customer_Name, Customer_Phone, Customer_Address, Customer_Debt from customer  where Customer_Debt > 0 ";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                DebtCollectionDTO d = new DebtCollectionDTO();
                d.setName(rs.getString("Customer_Name"));
                d.setAddress(rs.getString("Customer_Address"));
                d.setPhone(rs.getString("Customer_Phone"));
                d.setDebt(BigDecimal.valueOf(rs.getDouble("Customer_Debt")));
                list.add(d);
            }
        }catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    public List<DebtCollectionDTO> searchDebtCollection(String ten, String sdt){
        List<DebtCollectionDTO> list = new ArrayList<>();
        String sql = "select c.Customer_Name, c.Customer_Phone,o.Amount_Owed from output_order o " +
                "inner join customer c on c.Customer_Id = o.Customer_Id " +
                "where (? is null or c.Customer_Name like ? ) and " +
                "(? is null or c.Customer_Phone like ? )";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, ten);
            st.setString(2, "%"+ten+"%");
            st.setString(3, sdt);
            st.setString(4, "%"+sdt+"%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                DebtCollectionDTO d = new DebtCollectionDTO();
                d.setName(rs.getString("Customer_Name"));
                d.setAddress("");
                d.setPhone(rs.getString("Customer_Phone"));
                d.setDebt(rs.getBigDecimal("Amount_Owed"));
                list.add(d);
            }
        }catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    public static void main(String[] args) {
        OutputDao outputDao = new OutputDao();



        // In kết quả ra màn hình

        // Test getDailyIncome
        Date date = new Date(124, 5, 18); // 18/6/2024 (tháng bắt đầu từ 0)

        // Test getDailyIncome
        double dailyIncome = outputDao.getDailyIncome(date);
        int count = outputDao.countOutputDetailsByDate(date);
        System.out.println("Daily Income on " + date + ": " + dailyIncome);
        System.out.println("Số lượng chi tiết đơn hàng vào ngày 18/6/2024: " + count);


        // Test getQuanlityProducts
        /*int quantity = outputDao.getQuanlityProducts(date);
        System.out.println("Quantity of Products Sold on " + date + ": " + quantity);

        */
        List<DebtCollectionDTO> debtCollectionList = outputDao.getAllDebtCollection();
        System.out.println("Debt Collection List:");
        for (DebtCollectionDTO debt : debtCollectionList) {
            System.out.println("Name: " + debt.getName() + ", Phone: " + debt.getPhone() + ", Debt: " + debt.getDebt());
        }

        // Test searchDebtCollection
        /*String searchName = "John"; // Thay bằng tên cần tìm kiếm
        String searchPhone = "123456789"; // Thay bằng số điện thoại cần tìm kiếm
        List<DebtCollectionDTO> searchResult = outputDao.searchDebtCollection(searchName, searchPhone);
        System.out.println("Search Result for Name: " + searchName + " and Phone: " + searchPhone);
        for (DebtCollectionDTO debt : searchResult) {
            System.out.println("Name: " + debt.getName() + ", Phone: " + debt.getPhone() + ", Debt: " + debt.getDebt());
        }*/
    }
}
