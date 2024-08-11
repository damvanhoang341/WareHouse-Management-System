package com.example.qlkh.Servlet.Supplier;

import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.Suppliers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UpdateSupplierServlet", value = "/UpdateSupplierServlet")
public class UpdateSupplierServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int uid = Integer.parseInt(request.getParameter("sid"));
        SupplierDAO supplierDAO = new SupplierDAO();
        request.setAttribute("supplier",supplierDAO.getSupplierById(uid));
        request.getRequestDispatcher("Supplier/update-supplier.jsp").forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String supplierName = request.getParameter("usuppliername");
        String supplierPhone = request.getParameter("usupplierphone");
        String supplierAddress = request.getParameter("uaddress");
        int supplierId = Integer.parseInt(request.getParameter("supplierId"));
        String taxCode = request.getParameter("taxCode");
        // Tạo đối tượng Supplier
        Suppliers supplier = new Suppliers();
        supplier.setSupplierId(supplierId);
        supplier.setSupplierName(supplierName);
        supplier.setSupplierPhone(supplierPhone);
        supplier.setSupplierAddress(supplierAddress);
        supplier.setTax(taxCode);
        // Gọi DAO để cập nhật thông tin nhà cung cấp
        SupplierDAO supplierDAO = new SupplierDAO();
        boolean updated = supplierDAO.updateSupplier(supplier);

        if (updated) {
            // Nếu cập nhật thành công, chuyển hướng về trang cập nhật thành công
            request.setAttribute("success","Cập nhật thành công ");
            List<Suppliers> suppliers = supplierDAO.getAllSuppliers();
            request.setAttribute("supplier", suppliers);
            request.getRequestDispatcher("Supplier/ListSuppliers.jsp").forward(request, response);
        } else {
            // Nếu cập nhật không thành công, chuyển hướng về trang lỗi
            request.setAttribute("error2","Câập nhật thất bại . Vui lòng thử lại");
            request.getRequestDispatcher("Supplier/update-supplier.jsp").forward(request,response);
        }
    }
}
