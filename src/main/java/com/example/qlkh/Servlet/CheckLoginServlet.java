package com.example.qlkh.Servlet;


import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.User;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.xml.bind.DatatypeConverter;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;


import java.io.IOException;
import java.util.List;


@WebServlet(name = "CheckLoginServlet", value = "/CheckLoginServlet")
public class CheckLoginServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("user");
        String password = request.getParameter("pass");

        HttpSession session = request.getSession();
        Integer count = (Integer) session.getAttribute("loginAttemptCount");

        if (count == null) {
            count = 0;
        }
        if (count >= 3) {
            request.setAttribute("error1", "Đã nhập sai quá 3 lần. Vui lòng đổi mật khẩu.");
            request.getRequestDispatcher("user/forgot-password.jsp").forward(request, response);
            return;
        }
        String hashedPassword = hashPassword(password);
        // Authenticate user
        UserDAO userDAO = new UserDAO();
        User user = userDAO.checkLogin(username, hashedPassword);


        if (user == null) {
            count++;
            session.setAttribute("loginAttemptCount", count);
            request.setAttribute("error", "Nhập sai tài khoản hoặc mật khẩu");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            // Check if the user has exceeded the maximum login attempts

        } else {
            // Reset login attempt count on successful login
            session.setAttribute("loginAttemptCount", 0);
            session.setAttribute("account", user);
            List<User> list = userDAO.getAllUser();
            request.setAttribute("data", list);
            response.sendRedirect("/generanity");
        }


    }
    private String hashPassword(String password) {
        try {
            // Tạo một thể hiện của MessageDigest với thuật toán SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            // Băm mật khẩu đầu vào (chuỗi password) thành mảng byte sử dụng SHA-256
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            // Chuyển đổi mảng byte thành chuỗi hexadecimal và chuyển thành chữ thường
            return DatatypeConverter.printHexBinary(hash).toLowerCase();
        } catch (NoSuchAlgorithmException e) {
            // Bắt ngoại lệ nếu thuật toán SHA-256 không tồn tại
            throw new RuntimeException(e);
        }
    }
}
