package com.example.qlkh.Servlet.thongKe;

import com.example.qlkh.DAO.*;
import com.example.qlkh.model.User;
import com.example.qlkh.model.product;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "controllerThongKe", value = "/generanity")
public class controllerThongKe extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Số lượng nhân viên
        UserDAO userDAO1 = new UserDAO();
        List<User> list = userDAO1.getAllUser();
        int sizeUser = list.size();
        request.setAttribute("sz", sizeUser);

        // Số lượng mặt hàng
        ProductDao proDao = new ProductDao();
        int sizeProduct = proDao.countAllProduct();
        request.setAttribute("szPro", sizeProduct);

        // earn money by date
        int totalIncome = 0;
        int totalProduct = 0;
        OutputDao out = new OutputDao();

        // Lấy ngày hiện tại nếu tham số 'date' không được cung cấp
        String dateString = request.getParameter("date");
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        if (dateString == null || dateString.isEmpty()) {
            dateString = dateFormat.format(new Date());
        }

        try {
            Date date = dateFormat.parse(dateString);
            totalIncome = (int) out.getDailyIncome(date);
            totalProduct = out.countOutputDetailsByDate(date);
            request.setAttribute("icomedate", dateFormat.format(date));
        } catch (ParseException e) {
            e.printStackTrace();
            String errorMsg = "Sai định dạng ngày";
            request.setAttribute("error", errorMsg);
        }

        request.setAttribute("income", totalIncome);
        request.setAttribute("numberProducts", totalProduct);

        //xuat khau
        Output_orderDAO context = new Output_orderDAO();
        int ListOutput_order = context.countOrders();
        request.setAttribute("numberexport", ListOutput_order);

        //nhap khau
        ImportDAO importDAO = new ImportDAO();
        int ListImport = importDAO.numberImports();
        request.setAttribute("numberimport", ListImport);

        //% nhap khau
        double percentageImport = ((double) ListImport / (double) (ListImport + ListOutput_order)) * 100;
        request.setAttribute("PercentageImport", String.format("%.2f", percentageImport));

        //% xuat khau
        double percentageExport = 100 - percentageImport;
        request.setAttribute("PercentageExport", String.format("%.2f", percentageExport));

        // Điều hướng sang trang JSP để hiển thị kết quả
        RequestDispatcher dispatcher = request.getRequestDispatcher("Generality.jsp");
        dispatcher.forward(request, response);
    }
}
