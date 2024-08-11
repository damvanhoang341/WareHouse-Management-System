package com.example.qlkh.Servlet.Revenue;

import com.example.qlkh.DAO.DebtDAO;
import com.example.qlkh.model.Revenue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Calendar;
import java.util.List;

@WebServlet(name = "RevenueReportServlet", value = "/RevenueReportServlet")
public class RevenueReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy tháng và năm hiện tại
        Calendar cal = Calendar.getInstance();
        int currentMonth = cal.get(Calendar.MONTH) + 1; // Tháng trong Java bắt đầu từ 0
        int currentYear = cal.get(Calendar.YEAR);

        // Lấy tham số month và year từ request
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");

        // Chuyển đổi monthParam và yearParam sang int (hoặc sử dụng Integer.parseInt() với xử lý lỗi)
        int month = (monthParam != null) ? Integer.parseInt(monthParam) : currentMonth;
        int year = (yearParam != null) ? Integer.parseInt(yearParam) : currentYear;

        // Kiểm tra nếu month và year là các giá trị hợp lệ (ở đây giả định tháng từ 1 đến 12 và năm từ 2020 đến 2030)
        if (month >= 1 && month <= 12 && year >= 2020 && year <= 2030) {
            // Gọi phương thức getTotalRevenueByMonth từ DebtDAO để lấy tổng doanh thu
            DebtDAO debtDAO = new DebtDAO();
            double totalRevenue = debtDAO.getTotalRevenueByMonth(month, year);
            List<Revenue> revenueList = debtDAO.getRevenueByMonth(month, year);
            // Lưu kết quả vào request để hiển thị trên trang JSP
            request.setAttribute("selectedMonth", month);
            request.setAttribute("selectedYear", year);
            request.setAttribute("totalRevenue", totalRevenue);
            request.setAttribute("revenue", revenueList);
        } else {
            // Nếu không hợp lệ, sử dụng tháng và năm hiện tại để hiển thị
            request.setAttribute("selectedMonth", currentMonth);
            request.setAttribute("selectedYear", currentYear);
        }

        // Forward đến trang JSP để hiển thị kết quả
        request.getRequestDispatcher("Revenue/Revenue_report.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int month = Integer.parseInt(request.getParameter("month"));
        int year = Integer.parseInt(request.getParameter("year"));

        DebtDAO debtDAO = new DebtDAO();
        double totalRevenue = debtDAO.getTotalRevenueByMonth(month, year);

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);

        request.getRequestDispatcher("Revenue/Revenue_report.jsp").forward(request, response);
    }
}
