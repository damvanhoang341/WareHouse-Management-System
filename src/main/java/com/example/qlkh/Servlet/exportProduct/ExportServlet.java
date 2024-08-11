package com.example.qlkh.Servlet.exportProduct;

import com.example.qlkh.DAO.*;
import com.example.qlkh.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.servlet.annotation.MultipartConfig;

@WebServlet(name = "ExportServlet", value = "/ExportServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ExportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ExportDAO e = new ExportDAO();
        CustomersDAO c = new CustomersDAO();
        ArrayList<Export> le = e.getExport();
        List<Customers> lc = c.getAllCustomers();
        request.setAttribute("list", le);
        request.setAttribute("lc", lc);
        request.getRequestDispatcher("export/createExport.jsp").forward(request, response);
    }

    private final String UPLOAD_DIR = "evidence";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");


        Map<String, String[]> parameterMap = request.getParameterMap();

        String codeN = parameterMap.get("orderCode")[0];
        int code = Integer.parseInt(codeN);
        int idCustomer = Integer.parseInt(parameterMap.get("customer")[0]);
        if(idCustomer == 0){
            String ms ="Vui lòng chọn khách hàng!";
            request.setAttribute("ms0",ms);
            doGet(request, response);
        }


        Part filePart = request.getPart("evidenceUpload");

        // Extract file name and save the file
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        ProductDao pd = new ProductDao();

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Save the file
        File file = new File(uploadPath + File.separator + fileName);
        filePart.write(file.getAbsolutePath());

        // Create link to the uploaded file
        String fileLink = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;




        // Chuyển đổi ngày từ String thành java.sql.Date
        java.sql.Date sqlDate = java.sql.Date.valueOf(parameterMap.get("day")[0]);

        String note = parameterMap.get("note")[0];
        float amountPaid = Float.parseFloat(request.getParameter("amountPaid"));
        float discount = Float.parseFloat(request.getParameter("discount"));

        ExportDAO ex = new ExportDAO();
        DebtDAO de = new DebtDAO();

        String productId;
        String productName;
        double productPrice;
        int productQuantity;
        double productTotal = 0;
        double result = 0;

        for (String key : parameterMap.keySet()) {
            if (key.startsWith("products")) {
                productId = key.split("\\[")[1].split("\\]")[0];
                productName = request.getParameter("products[" + productId + "][name]");
                productPrice = Double.parseDouble(request.getParameter(productId + "_price"));
                productQuantity = Integer.parseInt(request.getParameter(productId + "_quantity"));

                result += productPrice * productQuantity;
                ex.addProdExport(code, Integer.parseInt(productId), productQuantity, result);
                pd.updateProductInventory(Integer.parseInt(productId),productQuantity);
                productTotal += result;
                result = 0;
            }
        }


        productTotal = productTotal - (productTotal * discount / 100);

        // Gọi phương thức với java.sql.Date
        try {
            de.updateOrInsertRevenue(sqlDate, amountPaid);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        double Owed = productTotal - amountPaid;
        ex.addNewExport(code, idCustomer, account.getId(), sqlDate, discount, productTotal, amountPaid, Owed, fileLink, note);
        CustomersDAO cus = new CustomersDAO();
        cus.updateCustomerDebt(idCustomer,Owed);
        String ms = "Thêm thành công";
        request.setAttribute("ms", ms);
        doGet(request, response);
    }

}
