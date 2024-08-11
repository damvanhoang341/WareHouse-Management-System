package com.example.qlkh.DAO;


import com.example.qlkh.model.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DetailImportDAO extends DAO {

    public ArrayList<DetailImport> getDetailImport(int idImport) {
        ArrayList<DetailImport> list = new ArrayList<>();

        String sql = "SELECT * FROM swp_project.import_detail dt \n" +
                "left join swp_project.product p on dt.P_ID = p.P_Id \n" +
                "left join swp_project.car c on p.Car_ID = c.Car_Id\n" +
                "left join swp_project.supplier s on p.Supplier_Id = s.Supplier_Id\n" +
                " where dt.Import_Id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, idImport);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                DetailImport d = new DetailImport();
                d.setDetail_Id(rs.getInt("Detail_Id"));
                product p = new product();
                p.setP_id(rs.getInt("P_Id"));
                p.setProduct_name(rs.getString("Product_Name"));
                p.setUnit(rs.getString("Unit"));
                Car c = new Car();
                c.setCarId(rs.getInt("Car_Id"));
                c.setCarName(rs.getString("Car_Name"));
                p.setCar_id(c);
                Suppliers s = new Suppliers();
                s.setSupplierId(rs.getInt("Supplier_Id"));
                s.setSupplierName(rs.getString("Supplier_Name"));

                p.setSupplier_id(s);
                p.setImport_price(rs.getDouble("Import_Price"));
                p.setSale_price(rs.getDouble("Sales_Price"));
                d.setProd(p);
                d.setImport_Id(rs.getInt("Import_Id"));
                d.setImport_quantity(rs.getInt("import_quantity"));
                d.setProduct_total(rs.getDouble("product_total"));

                list.add(d);
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        DetailImportDAO dao = new DetailImportDAO();
        ArrayList<DetailImport> d = dao.getDetailImport(1552755410);
        for (DetailImport d1 : d) {
            System.out.println(d1.getProd());
        }
    }
}
