package com.example.qlkh.Servlet;

import com.example.qlkh.DAO.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.xml.bind.DatatypeConverter;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet(name = "ResetPasswordServlet", value = "/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("/user/update-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        UserDAO userDAO = new UserDAO();
        String otp = request.getParameter("otp");
        String email = (String) request.getSession().getAttribute("email");
        String newPassword = request.getParameter("newPassword");
        String RePassword = request.getParameter("repassword");
        String sessionOtp = (String) request.getSession().getAttribute("otp");

        if (otp.equals(sessionOtp)) {
            if(newPassword.length()<8){
                request.setAttribute("error3", "Mật khẩu phải có ít nhất 8 ký tự");
            }else{
                if(newPassword.equals(RePassword)) {
                    boolean isUpdated = userDAO.updatePassword(email,newPassword);
                    if (isUpdated) {
                        response.getWriter().println("Mật khẩu của bạn đã được cập nhật thành công.");
                        response.sendRedirect("/");
                    } else {
                        response.getWriter().println("Đã xảy ra lỗi khi cập nhật mật khẩu.");
                    }

                }else{
                    request.setAttribute("error3", "Mật khẩu nhập lại không trùng khớp");
                    request.getRequestDispatcher("/user/update-password.jsp").forward(request, response);
                }
            }
        } else {
            response.getWriter().println("Mã OTP không hợp lệ.");
        }
    }
    private boolean updatePassword(String newPassword) {

        return true; // Trả về true nếu cập nhật thành công, ngược lại trả về false
    }
}
