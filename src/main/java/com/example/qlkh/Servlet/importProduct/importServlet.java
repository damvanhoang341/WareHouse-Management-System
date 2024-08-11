package com.example.qlkh.Servlet.importProduct;

import com.example.qlkh.DAO.*;
import com.example.qlkh.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.List;
import java.util.Map;

import jakarta.servlet.annotation.MultipartConfig;

@WebServlet(name = "importServlet", value = "/importServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class importServlet extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "image";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ImportDAO e = new ImportDAO();
        WareHouseDAO w = new WareHouseDAO();
        SupplierDAO s = new SupplierDAO();
        List<Import> le = e.getProduct();
        List<WareHouse> lw = w.getAllWarehouses();
        List<Suppliers> ls = s.getAllSuppliers();

        request.setAttribute("list", le);
        request.setAttribute("lware", lw);
        request.setAttribute("lSup", ls);
        request.getRequestDispatcher("import/createImport.jsp").forward(request, response);

    }

    private final String UPLOAD_DIR = "evidence";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("evidenceUpload");

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Save the file
        File file = new File(uploadPath + File.separator + fileName);
        filePart.write(file.getAbsolutePath());

        String fileLink = request.getContextPath() + "/" + UPLOAD_DIR + "/" + fileName;

        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("account");

        Map<String, String[]> parameterMap = request.getParameterMap();

        String code = parameterMap.get("orderCode")[0];
        int idware = Integer.parseInt(parameterMap.get("wareHouse")[0]);
        Date d = Date.valueOf(parameterMap.get("day")[0]);
        String note = parameterMap.get("note")[0];
        ImportDAO im = new ImportDAO();

        String productId;
        String productName;
        double productPrice;
        int productQuantity;
        String supplier;
        double productTotal = 0;
        boolean check = true;
        double result = 0;

        for (String key : parameterMap.keySet()) {

            if (key.startsWith("products")) {


                    productId = key.split("\\[")[1].split("\\]")[0];
                    productName = request.getParameter("products[" + productId + "][name]");
                    productPrice = Double.parseDouble(request.getParameter(productId + "_price"));
                    productQuantity = Integer.parseInt(request.getParameter(productId + "_quantity"));
                    supplier = request.getParameter(productId + "_supplier");
                    result += productPrice * productQuantity;
                    im.addProdImport(code, Integer.parseInt(productId), productQuantity, result);
                    productTotal += result;
                    result = 0;
                }

            }


        im.addNewImport(code, productTotal, productTotal, d, account.getId(), note,fileLink, idware);
        String ms = "Thêm thành công";
        request.setAttribute("ms", ms);
        doGet(request, response);
    }
}


