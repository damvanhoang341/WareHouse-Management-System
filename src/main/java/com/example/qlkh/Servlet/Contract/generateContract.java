package com.example.qlkh.Servlet.Contract;

import com.example.qlkh.DAO.ExportDAO;
import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.Export;
import com.example.qlkh.model.Suppliers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@WebServlet(name = "generateContract", value = "/generateContract")
public class generateContract extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Contact/contract.jsp").forward(request,response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String contractDate = request.getParameter("contractDate");
        String contractLocation = request.getParameter("contractLocation");
        String sellerName = request.getParameter("sellerName");
        String sellerID = request.getParameter("sellerID");
        String sellerAddress = request.getParameter("sellerAddress");
        String sellerTax = request.getParameter("sellerTax");
        String sellerPhone = request.getParameter("sellerPhone");
        String buyerName = request.getParameter("buyerName");
        String buyerID = request.getParameter("buyerID");
        String buyerAddress = request.getParameter("buyerAddress");
        String buyerTax = request.getParameter("buyerTax");
        String buyerPhone = request.getParameter("buyerPhone");
        String[] itemIndices = request.getParameterValues("itemIndex");
        String[] itemNames = request.getParameterValues("itemName");
        String[] itemPrices = request.getParameterValues("itemPrice");
        String deliveryLocation = request.getParameter("deliveryLocation");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        // Thiết lập loại nội dung và tên file đính kèm
        response.setContentType("application/msword");
        response.setHeader("Content-Disposition", "attachment;filename=hop_dong_cung_cap_phu_tung_o_to.doc");

        // Tạo nội dung HTML cho hợp đồng
        StringBuilder itemList = new StringBuilder();
        if (itemIndices != null && itemNames != null && itemPrices != null) {
            itemList.append("<table border='1' cellspacing='0' cellpadding='5'>");
            itemList.append("<tr><th>STT</th><th>Tên mặt hàng</th><th>Giá nhập</th></tr>");
            for (int i = 0; i < itemIndices.length; i++) {
                itemList.append("<tr><td>")
                        .append(itemIndices[i])
                        .append("</td><td>")
                        .append(itemNames[i])
                        .append("</td><td>")
                        .append(itemPrices[i])
                        .append("</td></tr>");
            }
            itemList.append("</table>");
        }

        String content = "<html xmlns:o='urn:schemas-microsoft-com:office:office'\n" +
                "      xmlns:w='urn:schemas-microsoft-com:office:word'\n" +
                "      xmlns='http://www.w3.org/TR/REC-html40'>\n" +
                "<head><meta charset='utf-8'><title>Hợp đồng cung cấp linh kiện ô tô</title></head>\n" +
                "<body>\n" +
                "<div class='contract-header'>\n" +
                "    <h1>CỘNG HÒA XÃ HỘI CHỦ NGHĨA VIỆT NAM</h1>\n" +
                "    <h2>Độc lập - Tự do - Hạnh phúc</h2>\n" +
                "    <hr>\n" +
                "    <h3>HỢP ĐỒNG CUNG CẤP LINH KIỆN Ô TÔ</h3>\n" +
                "</div>\n" +
                "<div class='contract-content'>\n" +
                "    <p><strong>Căn cứ:</strong> Bộ luật dân sự 2015</p>\n" +
                "    <p>Hôm nay, ngày " + formatDate(contractDate) + ", tại " + contractLocation + ", chúng tôi gồm:</p>\n" +
                "</div>\n" +
                "<div class='form-group'>\n" +
                "    <h4>BÊN A: (Bên bán)</h4>\n" +
                "    <p>Tên: " + sellerName + "</p>\n" +
                "    <p>CMND số: " + sellerID + "</p>\n" +
                "    <p>Địa chỉ thường trú: " + sellerAddress + "</p>\n" +
                "    <p>Mã số thuế: " + sellerTax + "</p>\n" +
                "    <p>Số điện thoại liên lạc: " + sellerPhone + "</p>\n" +
                "</div>\n" +
                "<div class='form-group'>\n" +
                "    <h4>BÊN B: (Bên mua)</h4>\n" +
                "    <p>Tên: " + buyerName + "</p>\n" +
                "    <p>CMND số: " + buyerID + "</p>\n" +
                "    <p>Địa chỉ thường trú: " + buyerAddress + "</p>\n" +
                "    <p>Mã số thuế: " + buyerTax + "</p>\n" +
                "    <p>Số điện thoại liên lạc: " + buyerPhone + "</p>\n" +
                "</div>\n" +
                "<div class='contract-content'>\n" +
                "    <h4>ĐIỀU 1: Nội dung của hợp đồng</h4>\n" +
                "    <p>1. Đối tượng của hợp đồng: Cung cấp linh kiện ô tô theo danh sách dưới đây:</p>\n" +
                itemList.toString() +
                "    <p>2. Địa điểm giao hàng: " + deliveryLocation + "</p>\n" +
                "</div>\n" +
                "<div class='contract-content'>\n" +
                "    <h4>ĐIỀU 2: Thời hạn thực hiện hợp đồng</h4>\n" +
                "    <p>Hợp đồng được thực hiện từ ngày " + formatDate(startDate) + " đến ngày " + formatDate(endDate) + ".</p>\n" +
                "</div>\n" +
                "<div class='contract-content'>\n" +
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

        // Ghi nội dung vào OutputStream để xuất file Word
        try (OutputStream out = response.getOutputStream()) {
            out.write(content.getBytes(StandardCharsets.UTF_8));
        }
    }

    // Phương thức để định dạng ngày tháng từ form
    private String formatDate(String dateStr) {
        return DateTimeFormatter.ofPattern("dd/MM/yyyy", Locale.ENGLISH).format(LocalDate.parse(dateStr));
    }
}
