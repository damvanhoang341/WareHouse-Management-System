package com.example.qlkh.Servlet;

import com.example.qlkh.DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet(name = "SendOTPServlet", value = "/SendOTPServlet")
public class SendOTPServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        addSecurityHeaders(response);
        request.getRequestDispatcher("/user/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        addSecurityHeaders(response);

        String email = request.getParameter("email");
        UserDAO u = new UserDAO();
        if (u.checkEmail(email)) {
            String otp = generateOTP();
            sendEmail(email, otp);
            request.getSession().setAttribute("email", email);
            request.getSession().setAttribute("otp", otp);
            response.sendRedirect("/ResetPasswordServlet");
        } else {
            request.setAttribute("error1", "Email không có trong danh sách tài khoản");
            request.getRequestDispatcher("/user/forgot-password.jsp").forward(request, response);
        }
    }

    private String generateOTP() {
        return String.valueOf((int) (Math.random() * 900000) + 100000);
    }

    private void sendEmail(String email, String otp) {
        String host = "smtp.gmail.com";
        final String user = "quangvd1192001@gmail.com";
        final String password = "zwbtmcekjtvvtean";

        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Your OTP");
            message.setText("Your OTP is: " + otp);

            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

    private void addSecurityHeaders(HttpServletResponse response) {
        response.setHeader("Content-Security-Policy", "frame-ancestors 'self'");
        response.setHeader("X-Frame-Options", "DENY");
    }
}
