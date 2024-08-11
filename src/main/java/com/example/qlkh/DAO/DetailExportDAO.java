package com.example.qlkh.DAO;

import com.example.qlkh.model.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;



public class DetailExportDAO extends DAO {

    public ArrayList<DetailExport> getDetailExport(int code) {
        ArrayList<DetailExport> list = new ArrayList<>();

        String sql = "SELECT * FROM swp_project.output_detail od left join swp_project.output_order o on o.Output_Id = od.Output_Id \n" +
                " left join swp_project.product p on od.P_ID = p.P_Id \n" +
                "left join swp_project.car c on p.Car_ID = c.Car_Id\n" +
                "left join swp_project.shipment s on p.Shipment_Id = s.Shipment_Id\n" +
                "left join swp_project.warehouse w on s.Shipment_Id = w.Warehouse_Id\n" +
                "where od.Output_Id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, code);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DetailExport d = new DetailExport();
                d.setDetail_Id(rs.getInt("Detail_Id"));
                product p = new product();
                p.setP_id(rs.getInt("P_Id"));
                p.setProduct_name(rs.getString("Product_Name"));
                p.setUnit(rs.getString("Unit"));
                Car c = new Car();
                c.setCarId(rs.getInt("Car_Id"));
                c.setCarName(rs.getString("Car_Name"));
                p.setCar_id(c);
                d.setnShipment(rs.getString("Place"));
                d.setnWarehouse(rs.getString("Warehouse_Name"));
                p.setImport_price(rs.getDouble("Import_Price"));
                p.setSale_price(rs.getDouble("Sales_Price"));
                d.setProd(p);
                d.setAddedExport(rs.getString("AddedExport"));
                d.setExport_quantity(rs.getInt("export_quantity"));
                d.setProduct_total(rs.getDouble("product_total"));

                list.add(d);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
      }


     public static void main(String[] args) {
         DetailExportDAO dao = new DetailExportDAO();
         ArrayList<DetailExport> d = dao.getDetailExport(467137027);
         for (DetailExport d1 : d) {
             System.out.println(d1.getProd());
         }
     }
}
