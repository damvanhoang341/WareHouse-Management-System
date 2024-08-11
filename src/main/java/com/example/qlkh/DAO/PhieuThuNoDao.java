package com.example.qlkh.DAO;

import com.example.qlkh.model.PhieuThuNo;
import com.example.qlkh.model.collectionDebt;
import com.example.qlkh.model.product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhieuThuNoDao extends DAO{

    public PhieuThuNo getPhieuThuNo(String code) {
        String sql = "SELECT de.booking_code, de.so_tien, de.Dates, de.Descriptions, de.Pay_method, c.Customer_Name, a.Staff_Name " +
                "FROM debt_collection de " +
                "JOIN customer c ON de.customer_id = c.Customer_Id " +
                "JOIN account a ON de.employee_id = a.Account_Id " +
                "WHERE de.booking_code = ?";
        PhieuThuNo ptn = null;

        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, code);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                ptn = new PhieuThuNo();
                ptn.setCode(rs.getString("booking_code"));
                ptn.setDate(rs.getDate("Dates"));
                ptn.setMoney(rs.getDouble("so_tien"));
                ptn.setCustomersName(rs.getString("Customer_Name"));
                ptn.setEmployeesName(rs.getString("Staff_Name"));
                ptn.setPhuongThucChuyen(rs.getString("Pay_method"));
                ptn.setDes(rs.getString("Descriptions"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return ptn;
    }


    //tra danh sach
    public List<PhieuThuNo>listPhieuThu() {
        List<PhieuThuNo>list = new ArrayList<>();
        String sql = "SELECT de.booking_code, de.so_tien, de.Dates, de.Descriptions, de.Pay_method, c.Customer_Name, a.Staff_Name FROM debt_collection de"
                + " JOIN customer c ON de.customer_id = c.Customer_Id"
                + " JOIN account a ON de.employee_id = a.Account_Id";

        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                PhieuThuNo ptn = new PhieuThuNo();
                ptn.setCode(rs.getString("booking_code"));
                ptn.setDate(rs.getDate("Dates"));
                ptn.setMoney(rs.getDouble("so_tien"));
                ptn.setCustomersName(rs.getString("Customer_Name"));
                ptn.setEmployeesName(rs.getString("Staff_Name"));
                ptn.setPhuongThucChuyen(rs.getString("Pay_method"));
                ptn.setDes(rs.getString("Descriptions"));
                ptn.setDate(rs.getDate("Dates"));
                list.add(ptn);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        PhieuThuNoDao dao = new PhieuThuNoDao();
        List<PhieuThuNo> phieuThuList = dao.listPhieuThu();

        // In kết quả
        for (PhieuThuNo ptn : phieuThuList) {
            System.out.println("Code: " + ptn.getCode());
            System.out.println("Date: " + ptn.getDate());
            System.out.println("Money: " + ptn.getMoney());
            System.out.println("Customer's Name: " + ptn.getCustomersName());
            System.out.println("Employee's Name: " + ptn.getEmployeesName());
            System.out.println("Payment Method: " + ptn.getPhuongThucChuyen());
            System.out.println("Description: " + ptn.getDes());
            System.out.println("---------------------------------");
        }

    }

}
