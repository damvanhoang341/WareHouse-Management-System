package com.example.qlkh.Servlet.phieuThu_traNo;

import com.example.qlkh.DAO.CustomersDAO;
import com.example.qlkh.DAO.DebtDAO;
import com.example.qlkh.DAO.PhieuThuNoDao;
import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.Customers;
import com.example.qlkh.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import com.example.qlkh.model.collectionDebt;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "collectionServlet", value = "/collectionServlet")
public class collectionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserDAO userDao = new UserDAO();
        CustomersDAO customersDao = new CustomersDAO();
        String date = request.getParameter("date");
        String amountStr = request.getParameter("amount");
        String paymentMethod = request.getParameter("account");
        String partnerIdStr = request.getParameter("partner");
        String employeeIdStr = request.getParameter("recipient");
        String description = request.getParameter("description");
        collectionDebt d = new collectionDebt();

        // Kiểm tra các tham số đầu vào
        String errorMessage = validateInput(partnerIdStr, amountStr, date, employeeIdStr, paymentMethod);
        if (!errorMessage.isEmpty()) {
            setRequestAttributes(request, userDao);
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("phieuThuNo.jsp").forward(request, response);
            return;
        }

        double amount = 0;
        int partnerId = 0;
        int employee = 0;
        try {
            amount = Double.parseDouble(amountStr);
            partnerId = Integer.parseInt(partnerIdStr);
            employee = Integer.parseInt(employeeIdStr);
        } catch (NumberFormatException e) {
            setRequestAttributes(request, userDao);
            request.setAttribute("error", "Thông tin nhập vào không hợp lệ.");
            request.getRequestDispatcher("phieuThuNo.jsp").forward(request, response);
            return;
        }

        // Kiểm tra số nợ hiện tại của khách hàng
        Customers customer = customersDao.getCustomerById(partnerId);
        if (customer == null) {
            setRequestAttributes(request, userDao);
            request.setAttribute("error", "Khách hàng không tồn tại.");
            request.getRequestDispatcher("phieuThuNo.jsp").forward(request, response);
            return;
        }

        double currentDebt = customer.getCustomerDebt();
        if (amount > currentDebt) {
            setRequestAttributes(request, userDao);
            request.setAttribute("error", "Số tiền thu phải bé hơn hoặc bằng số nợ hiện tại.");
            request.getRequestDispatcher("phieuThuNo.jsp").forward(request, response);
            return;
        }

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = sdf.parse(date);
            java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());
            d.setDate(sqlDate);
        } catch (ParseException e) {
            e.printStackTrace();
            setRequestAttributes(request, userDao);
            request.setAttribute("error", "Định dạng ngày không hợp lệ.");
            request.getRequestDispatcher("phieuThuNo.jsp").forward(request, response);
            return;
        }

        d.setMoney(amount);
        d.setPayment_method(paymentMethod);
        d.setCustomerId(partnerId);
        d.setEmployeesId(employee);
        d.setDescription(description);

        DebtDAO debtDAO = new DebtDAO();
        boolean success = debtDAO.addDebtCollection(d);
        if (success) {
            PhieuThuNoDao p = new PhieuThuNoDao();
            request.setAttribute("lt", p.listPhieuThu());
            request.setAttribute("success", "Ghi sổ thành công");
            request.getRequestDispatcher("listPhieuThuNo.jsp").forward(request, response);
        } else {
            setRequestAttributes(request, userDao);
            request.setAttribute("error", "Ghi sổ thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("phieuThuNo.jsp").forward(request, response);
        }
    }

    private void setRequestAttributes(HttpServletRequest request, UserDAO userDao) throws ServletException, IOException {
        List<User> listUser = userDao.getAllUser();
        CustomersDAO customersDao = new CustomersDAO();
        List<Customers> customersList = customersDao.getDebtCustomers();
        request.setAttribute("CustomersList", customersList);
        request.setAttribute("listusers", listUser);
    }

    private String validateInput(String partnerIdStr, String amountPayStr, String dateStr, String employeeIdStr, String checkMethod) {
        StringBuilder errorMessage = new StringBuilder();
        // Kiểm tra mã đối tác
        if (partnerIdStr == null || partnerIdStr.isEmpty()) {
            errorMessage.append("Mã đối tác không được để trống. ");
        }
        // Kiểm tra số tiền
        if (amountPayStr == null || amountPayStr.isEmpty()) {
            errorMessage.append("Số tiền không được để trống. ");
        } else {
            try {
                Double amount = Double.parseDouble(amountPayStr);
                if (amount < 0) {
                    errorMessage.append("Số tiền không được âm. ");
                }
            } catch (NumberFormatException e) {
                errorMessage.append("Số tiền không hợp lệ. ");
            }
        }
        // Kiểm tra ngày
        if (dateStr == null || dateStr.isEmpty()) {
            errorMessage.append("Ngày không được để trống. ");
        }
        // Kiểm tra mã nhân viên
        if (employeeIdStr == null || employeeIdStr.isEmpty()) {
            errorMessage.append("Mã nhân viên không được để trống. ");
        }
        // Kiểm tra phương thức thanh toán
        if (checkMethod == null || checkMethod.isEmpty()) {
            errorMessage.append("Phương thức thanh toán không được để trống. ");
        }
        return errorMessage.toString().trim();
    }
}
