package com.example.qlkh.Servlet.uploads;

import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "UploadProfileImageServlet", value = "/UploadProfileImageServlet")
@MultipartConfig
public class UploadProfileImageServlet extends HttpServlet {
    // Đường dẫn tĩnh tới thư mục lưu trữ tệp
    private static final String STATIC_UPLOAD_DIRECTORY = "C:\\Users\\PC\\Downloads\\swp\\src\\main\\webapp\\uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        Part filePart = request.getPart("profileImageUpload");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Tạo tên tệp duy nhất bằng cách thêm timestamp và userID vào tên tệp gốc
            String uniqueFileName = user.getId() + "_" + new SimpleDateFormat("yyyyMM").format(new Date()) + "_" + fileName;

            String dynamicUploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
            File dynamicUploadDirFile = new File(dynamicUploadDir);
            if (!dynamicUploadDirFile.exists()) {
                dynamicUploadDirFile.mkdir();
            }
            String dynamicFilePath = dynamicUploadDir + File.separator + uniqueFileName;

            // Tải tệp lên thư mục tạm thời
            filePart.write(dynamicFilePath);

            // Sao chép tệp vào thư mục tĩnh nếu chưa tồn tại
            File staticUploadDirFile = new File(STATIC_UPLOAD_DIRECTORY);
            if (!staticUploadDirFile.exists()) {
                staticUploadDirFile.mkdirs();
            }
            String staticFilePath = STATIC_UPLOAD_DIRECTORY + File.separator + uniqueFileName;
            if (!Files.exists(Paths.get(staticFilePath))) {
                Files.copy(Paths.get(dynamicFilePath), Paths.get(staticFilePath));
            }

            String imagePath = "uploads/" + uniqueFileName;
            user.setProfileImage(imagePath);

            UserDAO userDAO = new UserDAO();
            userDAO.updateUserProfileImage(user);

            session.setAttribute("account", user);
        } else {
            response.sendRedirect("user/User_profile.jsp?uploadStatus=fail");
            return;
        }

        response.sendRedirect("/userProfileServlet");
    }
}
