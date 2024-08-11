package com.example.qlkh.DAO;
import com.example.qlkh.model.Car;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CarDAO extends DAO {
    private int noOfRecords;

    public Car getCarById(int id) {
        String sql = "SELECT * FROM Car WHERE Car_Id = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Car car = new Car();
                car.setCarId(rs.getInt("Car_Id"));
                car.setCarName(rs.getString("Car_Name"));
                car.setCarOrigin(rs.getString("Car_origin"));
                car.setCarDescription(rs.getString("Car_description"));
                return car;
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        return null;
    }

    public List<Car> getAllCar() {
        List<Car> car = new ArrayList<>();
        String sql = "SELECT * FROM Car ";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Car c = new Car();
                c.setCarId(rs.getInt("Car_Id"));
                c.setCarName(rs.getString("Car_name"));
               c.setCarOrigin(rs.getString("Car_origin"));
                c.setCarDescription(rs.getString("Car_description"));
                car.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return car;
    }

    public List<Car> getCarsByPage(int offset, int noOfRecords) {
        List<Car> carList = new ArrayList<>();
        String sql = "SELECT SQL_CALC_FOUND_ROWS * FROM Car LIMIT ?, ?";
        try {
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setInt(1, offset);
            statement.setInt(2, noOfRecords);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Car c = new Car();
                c.setCarId(rs.getInt("Car_Id"));
                c.setCarName(rs.getString("Car_name"));
                c.setCarOrigin(rs.getString("Car_origin"));
                c.setCarDescription(rs.getString("Car_description"));
                carList.add(c);
            }

            rs.close();

            rs = statement.executeQuery("SELECT FOUND_ROWS()");
            if (rs.next()) {
                this.noOfRecords = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Get cars by page: " + e);
        }

        return carList;
    }

    public int getNoOfRecords() {
        return noOfRecords;
    }

    // Thêm xe mới
    public boolean addCar(Car car) {
        String sql = "INSERT INTO Car (car_name, car_origin, car_description) VALUES (?, ?, ?)";
        try {
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, car.getCarName());
            statement.setString(2,car.getCarOrigin());
            statement.setString(3, car.getCarDescription());
            int rowUpdate = statement.executeUpdate();
            return rowUpdate > 0;
        } catch (SQLException e) {
           return false;
        }
    }

    // Cập nhật xe
    public boolean updateCar(Car car) {
        String sql = "UPDATE Car SET car_name = ?, car_description = ? , car_origin= ? WHERE Car_Id = ?";
        try {
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, car.getCarName());
            statement.setString(2, car.getCarDescription());
            statement.setString(3, car.getCarOrigin());
            statement.setInt(4, car.getCarId());
            int rowsUpdated = statement.executeUpdate();

            // Nếu có ít nhất một hàng bị ảnh hưởng, trả về true
            return rowsUpdated > 0;
        } catch (SQLException e) {
            return false;
        }
    }


    public static void main(String[] args) {
        CarDAO dao = new CarDAO();
        System.out.println(dao.getCarById(1));
    }
}
