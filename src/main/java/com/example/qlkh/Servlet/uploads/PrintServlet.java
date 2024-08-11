package com.example.qlkh.Servlet.uploads;

import com.example.qlkh.DAO.CustomersDAO;
import com.example.qlkh.DAO.PhieuThuNoDao;
import com.example.qlkh.DAO.UserDAO;
import com.example.qlkh.model.Customers;
import com.example.qlkh.model.PhieuThuNo;
import com.example.qlkh.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(value = "/PrintServlet")
public class PrintServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PhieuThuNoDao dao = new PhieuThuNoDao();
        String recordId = request.getParameter("receiptId");
        PhieuThuNo ptn = dao.getPhieuThuNo(recordId);

        if (ptn != null) {
            // Lấy thông tin từ đối tượng ptn
            String date = ptn.getDate().toString();
            String amount = String.valueOf(ptn.getMoney());
            String account = ptn.getPhuongThucChuyen();
            String recipientName = ptn.getEmployeesName();
            String partnerName = ptn.getCustomersName();
            String description = ptn.getDes();
            // Create HTML content for the Word document with CSS
            String content = "<html xmlns:o='urn:schemas-microsoft-com:office:office' \n" +
                    "      xmlns:w='urn:schemas-microsoft-com:office:word' \n" +
                    "      xmlns='http://www.w3.org/TR/REC-html40'>\n" +
                    "<head>\n" +
                    "    <meta charset='utf-8'>\n" +
                    "    <title>Phiếu Thu Nợ</title>\n" +
                    "    <style>\n" +
                    "        body { \n" +
                    "            font-family: 'Arial', sans-serif; \n" +
                    "            background-color: #f4f4f4;\n" +
                    "            padding: 20px;\n" +
                    "        }\n" +
                    "        .container {\n" +
                    "            background-color: #fff;\n" +
                    "            border-radius: 8px;\n" +
                    "            box-shadow: 0 0 10px rgba(0,0,0,0.1);\n" +
                    "            max-width: 800px;\n" +
                    "            margin: 0 auto;\n" +
                    "            padding: 20px;\n" +
                    "        }\n" +
                    "        .header { \n" +
                    "            text-align: center; \n" +
                    "            border-bottom: 2px solid #007bff;\n" +
                    "            padding-bottom: 10px;\n" +
                    "            margin-bottom: 20px;\n" +
                    "        }\n" +
                    "        .title { \n" +
                    "            font-size: 24px; \n" +
                    "            font-weight: bold; \n" +
                    "            color: #007bff; \n" +
                    "        }\n" +
                    "        .content { \n" +
                    "            margin-top: 20px; \n" +
                    "        }\n" +
                    "        .info { \n" +
                    "            margin-bottom: 20px; \n" +
                    "        }\n" +
                    "        .info p { \n" +
                    "            margin: 5px 0; \n" +
                    "        }\n" +
                    "        .signature {\n" +
                    "            width: 100%;\n" +
                    "            text-align: center; \n" +
                    "            margin-top: 30px;\n" +
                    "        }\n" +
                    "        .signature h4 {\n" +
                    "            margin-bottom: 20px;\n" +
                    "        }\n" +
                    "        .signature table {\n" +
                    "            width: 100%;\n" +
                    "        }\n" +
                    "        .signature td {\n" +
                    "            width: 50%;\n" +
                    "            padding: 20px;\n" +
                    "            vertical-align: top;\n" +
                    "        }\n" +
                    "        .signature td p {\n" +
                    "            margin: 0;\n" +
                    "        }\n" +
                    "    </style>\n" +
                    "</head>\n" +
                    "<body>\n" +
                    "    <div class=\"container\">\n" +
                    "        <div class=\"header\">\n" +
                    "            <h2 class=\"title\">PHIẾU THU NỢ</h2>\n" +
                    "        </div>\n" +
                    "        <div class=\"content\">\n" +
                    "            <div class=\"info\">\n" +
                    "                <p><strong>Số phiếu:</strong> " + recordId + "</p>\n" +
                    "                <p><strong>Ngày:</strong>" + date + "</p>\n" +
                    "                <p><strong>Số tiền:</strong>" +amount+"</p>\n" +
                    "                <p><strong>Phương thức thanh toán:</strong>"+account+"</p>\n" +
                    "                <p><strong>N.v nhận:</strong>"+recipientName+"</p>\n" +
                    "                <p><strong>Đối tác nhận:</strong> "+partnerName+"</p>\n" +
                    "                <p><strong>Diễn giải:</strong> "+description+"</p>\n" +
                    "            </div>\n" +
                    "            <div class=\"signature\">\n" +
                    "                <h4>Chữ ký của các bên</h4>\n" +
                    "                <table>\n" +
                    "                    <tr>\n" +
                    "                        <td>\n" +
                    "                            <p><strong>BÊN A</strong></p>\n" +
                    "                            <p>(Ký và ghi rõ họ tên)</p>\n" +
                    "                            <br><br><br>\n" +
                    "                        </td>\n" +
                    "                        <td>\n" +
                    "                            <p><strong>BÊN B</strong></p>\n" +
                    "                            <p>(Ký và ghi rõ họ tên)</p>\n" +
                    "                            <br><br><br>\n" +
                    "                        </td>\n" +
                    "                    </tr>\n" +
                    "                </table>\n" +
                    "            </div>\n" +
                    "        </div>\n" +
                    "    </div>\n" +
                    "</body>\n" +
                    "</html>\n";

            // Set response content type and header for Word document
            response.setContentType("application/msword");
            response.setHeader("Content-Disposition", "attachment; filename=phieu-thu-no.doc");

            // Write the document to the response output stream
            try (OutputStream out = response.getOutputStream()) {
                out.write(content.getBytes(StandardCharsets.UTF_8));
            }
        }
    }
}
