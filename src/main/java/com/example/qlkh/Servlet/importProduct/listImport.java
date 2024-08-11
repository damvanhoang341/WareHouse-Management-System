package com.example.qlkh.Servlet.importProduct;


import com.example.qlkh.DAO.DetailImportDAO;
import com.example.qlkh.DAO.ExportDAO;
import com.example.qlkh.DAO.ImportDAO;
import com.example.qlkh.model.Import;
import com.example.qlkh.model.ListImport;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;

import com.example.qlkh.model.Export;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "listImport", value = "/listImport")
public class listImport extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ImportDAO i = new ImportDAO();
        PrintWriter out = response.getWriter();
        ArrayList<ListImport> li = i.getListImport();
        request.setAttribute("list", li);

       request.getRequestDispatcher("import/listImport.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        request.getRequestDispatcher("import/listImport.jsp").forward(request, response);
    }
}
