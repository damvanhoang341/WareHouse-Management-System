package com.example.qlkh.DAO;

import java.sql.Connection;
import java.sql.DriverManager;

public class DAO {
    public static Connection con;

    public DAO() {
        if (con == null) {
            String dbUrl =
                    "jdbc:mysql://localhost:3306/swp_project?autoReconnect=false&useSSL=true&clientInteractive=true";
            String dbClass = "com.mysql.cj.jdbc.Driver";
            try {
                Class.forName(dbClass);
                con = DriverManager.getConnection(dbUrl, "root", "152003");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
