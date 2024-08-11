package com.example.qlkh.DAO;

import com.example.qlkh.model.*;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ExportDAO extends DAO{

    public ArrayList<Export> getExport(){
        ArrayList<Export> export = new ArrayList<>();

        String sql = "select p.P_id, p.Product_Name,c.Car_Name, p.Inventory, p.Unit, p.Import_Price, p.Sales_Price, S.*, wh.Warehouse_Name from swp_project.product p left join swp_project.car c on p.Car_Id = c.Car_Id left join swp_project.shipment S on p.Shipment_Id = S.Shipment_Id Join swp_project.warehouse wh on S.Warehouse_Id = wh.Warehouse_Id ";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Export e = new Export();
                e.setP_id(rs.getInt("P_Id"));
                e.setProduct_name(rs.getString("Product_Name"));
                e.setCar_name(rs.getString("Car_Name"));
                e.setInventory(rs.getInt("Inventory"));
                e.setUnit(rs.getString("Unit"));
                e.setPrice(rs.getFloat("Import_Price"));
                e.setSale_price(rs.getFloat("Sales_Price"));
                e.setNameWareH(rs.getString("Warehouse_Name"));
                e.setPlace(rs.getString("Place"));
                e.setSub_place(rs.getString("Place"));
                export.add(e);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return export;
    }

    public ArrayList<ListExport> getListExport(){
        ArrayList<ListExport> list = new ArrayList<>();

        String sql = "SELECT\n" +
                "                O.*, C.*, A.*,CT.*\n" +
                "                 FROM swp_project.output_order O \n" +
                "                left join swp_project.customer C on O.Customer_Id = C.Customer_Id\n" +
                "                left join swp_project.account A on O.Seller = A.Account_Id \n" +
                "                left join swp_project.customer_type CT on C.Type_Id = CT.Type_Id;";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ListExport li = new ListExport();
                // new customer

                Customers cs = new Customers();
                cs.setCustomerId(rs.getInt("Customer_Id"));
                cs.setCustomerName(rs.getString("Customer_Name"));
                cs.setCustomerPhone(rs.getString("Customer_Phone"));
                // new type customer type
                CustomerType ct = new CustomerType();
                ct.setCustomerTypeId(rs.getInt("Type_Id"));
                ct.setCustomerTypeName(rs.getString("Type_Names"));
                ct.setDiscount(rs.getFloat("Payment_Discount"));
                //add ct to cs
                cs.setCt_Id(ct);
                //add ur to cs
                li.setCustomer(cs);
                // add ur to cs
                User ur = new User();
                ur.setId(rs.getInt("Account_Id"));
                ur.setName(rs.getString("Staff_Name"));
                ur.setPhone(rs.getString("Phone"));
                ur.setEmail(rs.getString("Email"));
                ur.setAddress(rs.getString("SAddress"));
                ur.setUsername(rs.getString("Account_Name"));
                ur.setRoleId(rs.getInt("Role_Id"));

                li.setSellerId(ur);

                // Main
                li.setDiscount(rs.getFloat("discount"));
                li.setOutputId(rs.getInt("Output_Id"));
                li.setOutputDate(rs.getDate("Output_Date"));
                li.setTotalMoney(rs.getFloat("Total_money"));
                li.setPaid(rs.getFloat("Paid"));
                li.setAmount_Owed(rs.getFloat("Amount_Owed"));

                li.setAddedExport(rs.getString("AddedExport"));
                li.setNote(rs.getString("Note"));
                li.setEnvident(rs.getString("evedent"));
                li.setStatus(rs.getString("Check_status"));
                list.add(li);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public void addProdExport(int Output_Id, int P_id, int quantity, double total){


        try {
            String sql = "INSERT INTO swp_project.output_detail (Output_Id,P_ID, export_quantity,product_total ) VALUES (?, ?,?,?)";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, Output_Id);
            statement.setInt(2, P_id);
            statement.setInt(3, quantity);
            statement.setDouble(4, total);
            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void addNewExport(int orderCode, int idCustomer, int idSeller, Date date,double discount, double productTotal, double amountPaid, double Owed,String fileLink, String note){


        try {
            String sql = "INSERT INTO swp_project.output_order (Output_Id, Customer_Id, Seller,Output_Date ,discount, Total_money, Paid, Amount_Owed, Note, Check_status,evedent ,AddedExport) VALUES ( ?, ?, ?, ?,?, ?, ?, ?,?, 'Đã duyệt', ?, 'ADDED')";
            PreparedStatement statement = con.prepareStatement(sql);

            statement.setInt(1, orderCode);
            statement.setInt(2, idCustomer);
            statement.setInt(3, idSeller);
            statement.setDate(4, date);
            statement.setDouble(5, discount);
            statement.setDouble(6, productTotal);
            statement.setDouble(7, amountPaid);
            statement.setDouble(8, Owed);
            statement.setString(9, note);
            statement.setString(10, fileLink);


            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void ChangeStatusExport(String status, int id ){


        try {
            String sql = "UPDATE swp_project.output_order o SET o.Check_Status = ? WHERE o.Output_Id = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, id);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void ChangeAddedExport(String status, int id ){


        try {
            String sql = "UPDATE swp_project.output_order o SET o.AddedExport = ? WHERE o.Output_Id = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, id);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }


    public static void main(String[] args) {
        ExportDAO dao = new ExportDAO();
      dao.ChangeStatusExport("Chờ duyệt", 177622664);
    }
}
