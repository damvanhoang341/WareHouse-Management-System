package com.example.qlkh.Servlet;

import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import jakarta.xml.bind.DatatypeConverter;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.IOException;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "CreateUserServlet", value = "/CreateUserServlet")
public class CreateUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/user/add-user.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        int role = Integer.parseInt(request.getParameter("role")) ;

        User newUser = new User();
        newUser.setName(name);
        newUser.setPhone(phone);
        newUser.setEmail(email);
        newUser.setAddress(address);
        newUser.setUsername(username);
        newUser.setPassword(hashPassword(password));
        newUser.setRoleId(role);
        UserDAO userDAO = new UserDAO();

        //Kiểm tra thông tin trùng va form email
        if(!validateEmail(email)){
            request.setAttribute("error2", "Email sai định dạng");
            request.getRequestDispatcher("/user/add-user.jsp").forward(request, response);
        }else{
            if(password.length()<8){
                request.setAttribute("error2", "Mật khẩu phải có ít nhất 8 ký tự");
            }else {
                if (userDAO.checkAccount(username) || userDAO.checkPhone(phone) || userDAO.checkEmail(email)) {
                    request.setAttribute("error2", "Thông tin đã tồn tại trong hệ thống");
                    request.getRequestDispatcher("/user/add-user.jsp").forward(request, response);
                } else {
                    boolean check = userDAO.addUser(newUser);
                    if (check) {
                        response.sendRedirect(request.getContextPath() + "/ListUserServlet");
                        sendAccount(email, username, password);
                    } else {
                        response.sendRedirect(request.getContextPath() + "/addUser");
                    }
                }
            }
        }
    }

    // check form email
    private static final String EMAIL_REGEX =
            "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@" +
                    "(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
    private static final Pattern pattern = Pattern.compile(EMAIL_REGEX);
    public static boolean validateEmail(String email) {
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }


    // gui email
    private void sendAccount(String email, String username , String SetPassword) {
        String host = "smtp.gmail.com";
        final String user = "tranquanghuy05072000@gmail.com";
        final String password = "fhxqhzqwbrwcgzfe";

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
            message.setSubject("Your Account");
            message.setText("Your Account Name: " + username + "\nYour Account Password: " + SetPassword);
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes(StandardCharsets.UTF_8));
            return DatatypeConverter.printHexBinary(hash).toLowerCase();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

}
