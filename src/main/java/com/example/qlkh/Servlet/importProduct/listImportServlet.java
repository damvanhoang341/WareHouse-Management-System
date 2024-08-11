package com.example.qlkh.Servlet.exportProduct;


import com.example.qlkh.DAO.ExportDAO;
import com.example.qlkh.DAO.ImportDAO;
import com.example.qlkh.DAO.SupplierDAO;
import com.example.qlkh.model.ListImport;
import com.example.qlkh.model.Suppliers;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import com.example.qlkh.model.Export;


@WebServlet(name = "listImportServlet", value = "/listImportServlet")
public class listImportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ImportDAO i = new ImportDAO();
        ArrayList<ListImport> li = i.getListImport();

        request.setAttribute("list", li);

        request.getRequestDispatcher("import/listImport.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ExportDAO e = new ExportDAO();
        ArrayList<Export> l = e.getExport();
        request.setAttribute("list", l);
        request.getRequestDispatcher("import/listImport.jsp").forward(request, response);
    }
}
