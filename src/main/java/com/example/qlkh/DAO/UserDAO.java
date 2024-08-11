package com.example.qlkh.DAO;

import com.example.qlkh.model.User;
import jakarta.xml.bind.DatatypeConverter;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO extends DAO {

    // check login
    public User checkLogin(String user, String pass) {
        String sql = "SELECT * FROM account AS u WHERE u.Account_Name = ? AND u.Password = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new User(rs.getInt("Account_Id"),
                        rs.getString("Staff_Name"),
                        rs.getString("Phone"),
                        rs.getString("Email"),
                        rs.getString("SAddress"),
                        rs.getString("Account_Name"),
                        rs.getString("Password"),
                        rs.getInt("Role_Id"),
                        rs.getString("profileImage"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // check email tồn tại trong hệ thống
    public boolean checkEmail(String email) {
        boolean emailExists = false;
        String query = "SELECT COUNT(*) FROM Account WHERE Email = ?";
        try {
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                emailExists = resultSet.getInt(1) > 0;
            }
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return emailExists;
    }

    // Phương thức băm mật khẩu
    public String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            return DatatypeConverter.printHexBinary(hash).toLowerCase();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    // Đặt lại mật khẩu
    public boolean updatePassword(String email, String newPassword) {
        boolean check = true;
        String hashPassword = hashPassword(newPassword);
        String sql = "UPDATE account SET Password = ? WHERE Email = ?";
        try {
            PreparedStatement statement = con.prepareStatement(sql);
            statement.setString(1, hashPassword); // Sử dụng mật khẩu đã băm
            statement.setString(2, email);
            statement.executeUpdate();
            check = true;
            statement.close();
        } catch (Exception e) {
            e.printStackTrace();
            check = false;
        }
        return check;
    }

    // check tên tài khoản trùng
    public boolean checkAccount(String AccountName) {
        boolean AccountExists = false;
        String query = "SELECT COUNT(*) FROM Account WHERE Account_Name = ?";
        try {
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, AccountName);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                AccountExists = resultSet.getInt(1) > 0;
            }
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return AccountExists;
    }

    // kiểm tra trùng số điện thoại
    public boolean checkPhone(String phone) {
        boolean PhoneExists = false;
        String query = "SELECT COUNT(*) FROM Account WHERE Phone = ?";
        try {
            PreparedStatement statement = con.prepareStatement(query);
            statement.setString(1, phone);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                PhoneExists = resultSet.getInt(1) > 0;
            }
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return PhoneExists;
    }

    // truy xuất danh sách nhân viên
    public List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM account AS a WHERE a.Role_Id = 2 OR a.Role_Id = 3 OR a.Role_Id = 0 ";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("Account_Id"));
                user.setName(rs.getString("Staff_Name"));
                user.setUsername(rs.getString("Account_Name"));
                user.setPassword(rs.getString("Password"));
                user.setPhone(rs.getString("Phone"));
                user.setEmail(rs.getString("Email"));
                user.setAddress(rs.getString("SAddress"));
                user.setRoleId(rs.getInt("Role_Id"));
                user.setProfileImage(rs.getString("profileImage"));
                list.add(user);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public boolean addUser(User user) {
        boolean check = true;
        String sql = "INSERT INTO account (Staff_Name, Phone, Email, SAddress, Account_Name, Password, Role_Id, profileImage) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getUsername());
            ps.setString(6, user.getPassword());
            ps.setInt(7, user.getRoleId());
            ps.setString(8, user.getProfileImage());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            check = false;
        }
        return check;
    }

    public boolean deleteUser(int id) {
        boolean check = true;
        String sql = "DELETE FROM account AS a WHERE Account_Id = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            check = false;
        }
        return check;
    }

    public User getUserById(int accountId) {
        String sql = "SELECT Account_Id, Staff_Name, Phone, Email, SAddress, Account_Name, Password, Role_Id, profileImage FROM account WHERE Account_Id = ?";
        try (PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, accountId);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return new User(rs.getInt("Account_Id"),
                            rs.getString("Staff_Name"),
                            rs.getString("Phone"),
                            rs.getString("Email"),
                            rs.getString("SAddress"),
                            rs.getString("Account_Name"),
                            rs.getString("Password"),
                            rs.getInt("Role_Id"),
                            rs.getString("profileImage"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Return null if no record is found
    }

    public boolean updateUser(User user) {
        boolean check = true;
        String sql = "UPDATE account SET Staff_Name = ?, Phone = ?, Email = ?, SAddress = ?, Role_Id = ? WHERE Account_Id = ?";
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, user.getName());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getAddress());
            ps.setInt(5, user.getRoleId());
            ps.setInt(6, user.getId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            check = false;
        }
        return check;
    }

    public void updateUserProfileImage(User user) {
        String query = "UPDATE account SET profileImage = ? WHERE Account_Name = ?";
        try (PreparedStatement preparedStatement = con.prepareStatement(query)) {
            preparedStatement.setString(1, user.getProfileImage());
            preparedStatement.setString(2, user.getUsername());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        System.out.println(userDAO.getAllUser());
    }
}
