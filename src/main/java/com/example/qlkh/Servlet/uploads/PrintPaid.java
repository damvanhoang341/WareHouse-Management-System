package com.example.qlkh.Servlet.uploads;

import com.example.qlkh.DAO.RepaymentSlipDAO;
import com.example.qlkh.model.RepaymentSlip;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;

@WebServlet("/PrintPaid")
public class PrintPaid extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RepaymentSlipDAO dao = new RepaymentSlipDAO();
        String id = request.getParameter("receiptId");
        System.out.println(id);
        RepaymentSlip rep = dao.getRepaymentSlipById(id);
        // Create a simple HTML document
        String content = "<html xmlns:o='urn:schemas-microsoft-com:office:office' " +
                "xmlns:w='urn:schemas-microsoft-com:office:word' " +
                "xmlns='http://www.w3.org/TR/REC-html40'>\n" +
                "<head><meta charset='utf-8'><title>Phiếu Trả Nợ</title></head>\n" +
                "<body>\n" +
                "<div style='text-align: center;'>\n" +
                "    <hr>\n" +
                "    <h2>PHIẾU TRẢ NỢ</h2>\n" +
                "</div>\n" +
                "<div>\n" +
                "    <p><strong>Số phiếu:</strong> " +  rep.getCode() + "</p>\n" +
                "    <p><strong>Ngày:</strong> " +  rep.getDate() + "</p>\n" +
                "    <p><strong>Số tiền:</strong> " + rep.getAmountMoney() + "</p>\n" +
                "    <p><strong>Phương thức thanh toán:</strong> " + rep.getMethodPay() + "</p>\n" +
                "    <p><strong>Nhân viên nhận:</strong> " + rep.getEmployeeName() + "</p>\n" +
                "    <p><strong>Nhà cung cấp:</strong> " + rep.getSupplierName() + "</p>\n" +
                "</div>\n" +
                "<div>\n" +
                "    <h4>Chữ ký của các bên</h4>\n" +
                "    <table style='width: 100%;'>\n" +
                "        <tr>\n" +
                "            <td style='width: 50%; text-align: center;'>\n" +
                "                <p><strong>BÊN A</strong></p>\n" +
                "                <p>(Ký và ghi rõ họ tên)</p>\n" +
                "                <br><br><br>\n" +
                "            </td>\n" +
                "            <td style='width: 50%; text-align: center;'>\n" +
                "                <p><strong>BÊN B</strong></p>\n" +
                "                <p>(Ký và ghi rõ họ tên)</p>\n" +
                "                <br><br><br>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "    </table>\n" +
                "</div>\n" +
                "</body>\n" +
                "</html>";

        // Set response content type and header
        response.setContentType("application/msword");
        response.setHeader("Content-Disposition", "attachment; filename=phieu-tra-no.doc");

        // Write the document to the response output stream
        try (OutputStream out = response.getOutputStream()) {
            out.write(content.getBytes(StandardCharsets.UTF_8));
        }
    }
}
