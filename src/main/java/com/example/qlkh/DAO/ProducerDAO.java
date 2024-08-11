package com.example.qlkh.DAO;

import com.example.qlkh.model.producers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProducerDAO extends DAO {

    private Connection conn;

    public ProducerDAO() {
        try {
            conn = con;
        } catch (Exception e) {
            System.out.println("COnnection  fail: " + e);
        }
    }

    public List<producers> getAllProducer() {
        List<producers> producers = new ArrayList<>();
        producers object = null;
        String sql = "SELECT * FROM producer";
        try {
            PreparedStatement statement = conn.prepareStatement(sql);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                object = new producers();
                object.setProducer_Id(resultSet.getInt("Producer_Id"));
                object.setProducer_Name(resultSet.getString("Producer_Name"));
                producers.add(object);
            }
        } catch (Exception e) {
            System.out.println("Get producer: " + e);
        }

        return producers;
    }
}

