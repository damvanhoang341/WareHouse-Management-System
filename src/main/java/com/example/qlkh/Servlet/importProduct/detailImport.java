package com.example.qlkh.Servlet.importProduct;


import com.example.qlkh.DAO.*;
import com.example.qlkh.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "detailImport", value = "/detailImport")
public class detailImport extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idImport = Integer.parseInt(request.getParameter("idImport"));
        String addImport = request.getParameter("addImport");
        int warehouseId = Integer.parseInt(request.getParameter("idWare"));
        int idCreate = Integer.parseInt(request.getParameter("idCreater"));
        String note = request.getParameter("note");
        double total = Double.parseDouble(request.getParameter("total"));
        String status = request.getParameter("status");
        String img = request.getParameter("img");

        Date time = Date.valueOf(request.getParameter("time"));
        DetailImportDAO d = new DetailImportDAO();
        UserDAO u = new UserDAO();
        WareHouseDAO w = new WareHouseDAO();

        User account = (User) session.getAttribute("account");

        ArrayList<DetailImport> l = d.getDetailImport(idImport);
        User creater = u.getUserById(idCreate);
        WareHouse ware = w.getById(warehouseId);
        ShipmentDAO s = new ShipmentDAO();
        ArrayList<Shipment> shipment = s.getShipmentById(warehouseId);

        request.setAttribute("status", status);
        request.setAttribute("idImport",idImport);
        request.setAttribute("addImport", addImport);
        request.setAttribute("acc", account.getName());
        request.setAttribute("list", l);
        request.setAttribute("c", creater.getName());
        request.setAttribute("ware", ware.getName());
        request.setAttribute("note", note);
        request.setAttribute("time", time);
        request.setAttribute("total", total);
        request.setAttribute("shipment", shipment);
        request.setAttribute("img", img);
        request.getRequestDispatcher("import/detailImport.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       // PrintWriter out = response.getWriter();
        boolean check = Boolean.parseBoolean(request.getParameter("confirm"));
       // out.println(check);
        int idImport = Integer.parseInt(request.getParameter("idImport"));
        String addImport = request.getParameter("addImport");
        int index = 0;
        ImportDAO d = new ImportDAO();

        ProductDao p = new ProductDao();
        SupplierDAO s = new SupplierDAO();
        double total = Double.parseDouble(request.getParameter("total"));
        if (check) {
            d.ChangeStatusImport("Đã duyệt", idImport);
            if (addImport.equals("NOT")) {
                while (request.getParameter("products[" + index + "].p_id") != null) {
                int P_id = Integer.parseInt(request.getParameter("products[" + index + "].p_id"));
                int sup_id = Integer.parseInt(request.getParameter("products[" + index + "].supplier_id"));
                int quantity = Integer.parseInt(request.getParameter("products[" + index + "].import_quantity"));
                double prod_total = Double.parseDouble(request.getParameter("products[" + index + "].product_total"));
                int ship_id = Integer.parseInt(request.getParameter("products[" + index + "].shipment_id"));

                p.importProduct(P_id, quantity, ship_id);
                s.debtSupplier(sup_id, prod_total);
                d.ChangeAddedImport("ADDED", idImport);
                index++;
        }
        }

        }
        if(!check) {
            d.ChangeStatusImport("Từ chối", idImport);
            if (addImport.equals("ADDED")) {
            while (request.getParameter("products[" + index + "].p_id") != null) {
                int P_id = Integer.parseInt(request.getParameter("products[" + index + "].p_id"));
                int sup_id = Integer.parseInt(request.getParameter("products[" + index + "].supplier_id"));
                int quantity = Integer.parseInt(request.getParameter("products[" + index + "].import_quantity"));
                double prod_total = Double.parseDouble(request.getParameter("products[" + index + "].product_total"));

                p.reImportProduct(P_id, quantity);
                s.reDebtSupplier(sup_id, prod_total);
                d.ChangeAddedImport("NOT", idImport);
                index++;
            }
            }
        }
        String ms="Chỉnh sửa thành công";
        request.setAttribute("ms", ms);
        request.getRequestDispatcher("import/detailImport.jsp").forward(request, response);
    }
}
