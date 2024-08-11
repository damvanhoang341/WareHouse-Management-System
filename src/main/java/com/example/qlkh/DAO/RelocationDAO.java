package com.example.qlkh.DAO;

import com.example.qlkh.model.*;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RelocationDAO extends DAO{
    public ArrayList<ListRelocation> listReloca() {
        ArrayList<ListRelocation> list = new ArrayList<>();
        String sql = "SELECT * FROM swp_project.freight f left join swp_project.product p \n" +
                "on f.P_Id = p.P_Id left join swp_project.shipment s \n" +
                "on s.Shipment_Id = f.id_ShipmentNew left join swp_project.warehouse w\n" +
                "on w.Warehouse_Id = s.Warehouse_Id left join\n" +
                "swp_project.car c on p.Car_Id = c.Car_Id;";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
               ListRelocation L = new ListRelocation();
               L.setId_freight(rs.getInt("id_freight"));
               product p = new product();
               p.setP_id(rs.getInt("P_Id"));
               p.setProductCode(rs.getString("Product_code"));
               p.setProduct_name(rs.getString("Product_Name"));
               Car c = new Car();
               c.setCarId(rs.getInt("Car_Id"));
               c.setCarName(rs.getString("Car_Name"));
               p.setCar_id(c);
               p.setInventory(rs.getInt("Inventory"));
               p.setUnit(rs.getString("Unit"));
               L.setId_Product(p);
               Shipment s = new Shipment();
               s.setShipment_Id(rs.getInt("id_ShipmentNew"));
               s.setPlace_include(rs.getString("Place"));
               L.setId_ShipmentNew(s);
               WareHouse w = new WareHouse();
               w.setId(rs.getInt("Warehouse_Id"));
               w.setName(rs.getString("Warehouse_Name"));
               L.setWareHouse(w);
               L.setStatus_product(rs.getString("status_product"));
               L.setCheck(rs.getString("checked"));
               list.add(L);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void ChangeRelocation(String status, String check, int id ){


        try {
            String sql = "UPDATE swp_project.freight f SET f.checked = ?, f.status_product = ? WHERE f.id_freight = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, check);
            statement.setString(2, status);
            statement.setInt(3, id);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void ChangePlace(int p_id , int idShipment ){


        try {
            String sql = "UPDATE swp_project.product p SET p.Shipment_Id = ? WHERE p.P_Id = ?";
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, idShipment);
            statement.setInt(2, p_id);


            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        }
    }


    public static void main(String[] args) {
        RelocationDAO dao = new RelocationDAO();
        dao.ChangePlace(1,2);



    }
}
