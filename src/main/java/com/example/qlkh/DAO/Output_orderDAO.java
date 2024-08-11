package com.example.qlkh.DAO;
import com.example.qlkh.model.Import;
import com.example.qlkh.model.output_order;
import com.example.qlkh.model.producers;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Output_orderDAO extends DAO{
    public int countOrders(){
        int count = 0;
        String sql = "SELECT COUNT(*) FROM output_order";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return count;
    }
}
