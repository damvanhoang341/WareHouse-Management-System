package com.example.qlkh.Servlet.phieuThu_traNo;

import com.example.qlkh.DAO.CustomersDAO;
import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.Customers;
import com.example.qlkh.model.Suppliers;
import com.example.qlkh.model.User;
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

import com.example.qlkh.DAO.RepaymentSlipDAO;
import com.example.qlkh.model.RepaymentSlip;

@WebServlet(name = "ReplaymentSlipServlet", value = "/replaymentslip")

public class ReplaymentSlipServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO userDao = new UserDAO();
        SupplierDAO supplierDAO = new SupplierDAO();

        String partnerIdStr = req.getParameter("partner");
        String amountPayStr = req.getParameter("amount");
        String dateStr = req.getParameter("date");
        String employeeIdStr = req.getParameter("recipient");
        String checkMethod = req.getParameter("account");
        String reason = req.getParameter("description");

        // Validate input
        String errorMessage = validateInput(partnerIdStr, amountPayStr, dateStr, employeeIdStr, checkMethod, supplierDAO);
        if (!errorMessage.isEmpty()) {
            setRequestAttributes(req, userDao);
            req.setAttribute("error", errorMessage);
            req.getRequestDispatcher("phieuTraNo.jsp").forward(req, resp);
            return;
        }

        int idPartner = Integer.parseInt(partnerIdStr);
        double amountPay = Double.parseDouble(amountPayStr);
        int idEmployee = Integer.parseInt(employeeIdStr);

        RepaymentSlipDAO dao = new RepaymentSlipDAO();
        RepaymentSlip repaymentSlip = new RepaymentSlip();
        repaymentSlip.setSupplierId(idPartner);
        repaymentSlip.setAmountMoney(amountPay);
        repaymentSlip.setMethodPay(checkMethod);
        repaymentSlip.setReason(reason);

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = sdf.parse(dateStr);
            java.sql.Date sqlDate = new java.sql.Date(parsedDate.getTime());
            repaymentSlip.setDate(sqlDate);
        } catch (ParseException e) {
            setRequestAttributes(req, userDao);
            req.setAttribute("error", "Ngày không hợp lệ, vui lòng thử lại.");
            req.getRequestDispatcher("phieuTraNo.jsp").forward(req, resp);
            return;
        }

        repaymentSlip.setEmployee(idEmployee);
        boolean success = dao.addReplayment(repaymentSlip);
        if (success) {
            resp.sendRedirect("/listRepayment");
        } else {
            setRequestAttributes(req, userDao);
            req.setAttribute("error", "Không thành công, vui lòng thử lại.");
            req.getRequestDispatcher("phieuTraNo.jsp").forward(req, resp);
        }
    }

    private String validateInput(String partnerIdStr, String amountPayStr, String dateStr, String employeeIdStr, String checkMethod, SupplierDAO supplierDAO) {
        StringBuilder errorMessage = new StringBuilder();

        if (partnerIdStr == null || partnerIdStr.isEmpty()) {
            errorMessage.append("Mã đối tác không được để trống. ");
        }
        if (amountPayStr == null || amountPayStr.isEmpty()) {
            errorMessage.append("Số tiền không được để trống. ");
        } else {
            try {
                double amountPay = Double.parseDouble(amountPayStr);
                if (amountPay < 0) throw new NumberFormatException();

                // Check if repayment amount is greater than debt
                int partnerId = Integer.parseInt(partnerIdStr);
                 Suppliers s = supplierDAO.getSupplierById(partnerId); // Assumes this method exists in SupplierDAO
                if (amountPay > s.getDebt()) {
                    errorMessage.append("Số tiền trả phải bé hơn hoặc bằng số nợ. ");
                }
            } catch (NumberFormatException e) {
                errorMessage.append("Số tiền không hợp lệ. ");
            }
        }
        if (dateStr == null || dateStr.isEmpty()) {
            errorMessage.append("Ngày không được để trống. ");
        }
        if (employeeIdStr == null || employeeIdStr.isEmpty()) {
            errorMessage.append("Mã nhân viên không được để trống. ");
        }
        if (checkMethod == null || checkMethod.isEmpty()) {
            errorMessage.append("Phương thức thanh toán không được để trống. ");
        }
        return errorMessage.toString();
    }

    private void setRequestAttributes(HttpServletRequest request, UserDAO userDao) throws ServletException, IOException {
        UserDAO dat = new UserDAO();
        List<User> userList = dat.getAllUser();
        request.setAttribute("listofuser", userList);

        SupplierDAO supplierDAO = new SupplierDAO();
        List<Suppliers> suppliersList = supplierDAO.getDebtSuppliers();
        request.setAttribute("listofsuppliers", suppliersList);
    }
}
