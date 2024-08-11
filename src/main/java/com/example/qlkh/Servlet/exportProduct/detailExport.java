package com.example.qlkh.Servlet.exportProduct;

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

@WebServlet(name = "detailExport", value = "/detailExport")
public class detailExport extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        int idExport = Integer.parseInt(request.getParameter("outputId"));
        String addExport = request.getParameter("addEx");

        int idCreate = Integer.parseInt(request.getParameter("idCreater"));
        int idCustomer = Integer.parseInt(request.getParameter("idCustomer"));
        String nCustomer = request.getParameter("nCustomer");
        String nCreate = request.getParameter("nCreater");
        String note = request.getParameter("note");
        double total = Double.parseDouble(request.getParameter("total"));
        double paid = Double.parseDouble(request.getParameter("paid"));
        double owed = Double.parseDouble(request.getParameter("owed"));
        double dis = Double.parseDouble(request.getParameter("dis"));

        double discount = Double.parseDouble(request.getParameter("discount"));
        String img = request.getParameter("img");

        Date time = Date.valueOf(request.getParameter("time"));
        DetailExportDAO d = new DetailExportDAO();

        User account = (User) session.getAttribute("account");

        ArrayList<DetailExport> l = d.getDetailExport(idExport);

        request.setAttribute("idCustomer", idCustomer);
        request.setAttribute("nCustomer", nCustomer);

        request.setAttribute("idExport", idExport);
        request.setAttribute("addExport", addExport);
        request.setAttribute("acc", account.getName());
        request.setAttribute("list", l);
        request.setAttribute("idCre", idCreate);
        request.setAttribute("c", nCreate);
        request.setAttribute("note", note);
        request.setAttribute("time", time);
        request.setAttribute("discount",discount);

        request.setAttribute("total", total);
        request.setAttribute("paid", paid);
        request.setAttribute("owed", owed);
        request.setAttribute("dis", dis);
        request.setAttribute("img",img);

        request.getRequestDispatcher("export/detailExport.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        boolean check = Boolean.parseBoolean(request.getParameter("confirm"));
        int idExport = Integer.parseInt(request.getParameter("idExport"));
        String addExport = request.getParameter("addExport");
        double paid = Double.parseDouble(request.getParameter("paid"));
        int index = 0;
        ExportDAO d = new ExportDAO();
        ProductDao p = new ProductDao();
        DebtDAO de = new DebtDAO();
        double result = 0;


        double total = Double.parseDouble(request.getParameter("total"));
        if (check) {
            d.ChangeStatusExport("Đã duyệt", idExport);
            if (addExport.equals("NOT")) {
                while (request.getParameter("products[" + index + "].p_id") != null) {
                    int P_id = Integer.parseInt(request.getParameter("products[" + index + "].p_id"));
                    int quantity = Integer.parseInt(request.getParameter("products[" + index + "].export_quantity"));
                    double prod_total = Double.parseDouble(request.getParameter("products[" + index + "].product_total"));


                    p.exportProduct(P_id, quantity);
                     result = result + prod_total;

                    index++;
                }
                de.changeDebt(idExport, result - paid);
                d.ChangeAddedExport("ADDED", idExport);
            }
        }
        if (!check) {
            d.ChangeStatusExport("Từ chối", idExport);
            if (addExport.equals("ADDED")) {
                while (request.getParameter("products[" + index + "].p_id") != null) {
                    int P_id = Integer.parseInt(request.getParameter("products[" + index + "].p_id"));
                    int quantity = Integer.parseInt(request.getParameter("products[" + index + "].export_quantity"));
                    double prod_total = Double.parseDouble(request.getParameter("products[" + index + "].product_total"));

                    p.reExportProduct(P_id, quantity);
                    result = result + prod_total;

                    index++;
                }
                de.reChangeDebt(idExport,result - paid);
                d.ChangeAddedExport("NOT", idExport);
            }
        }
        String ms = "Chỉnh sửa thành công";
       request.setAttribute("ms", ms);
       request.getRequestDispatcher("export/detailExport.jsp").forward(request, response);
    }
}
