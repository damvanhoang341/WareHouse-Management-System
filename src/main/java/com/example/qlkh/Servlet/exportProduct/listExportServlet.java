package com.example.qlkh.Servlet.exportProduct;


import com.example.qlkh.DAO.ExportDAO;
import com.example.qlkh.model.ListExport;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.ArrayList;
import com.example.qlkh.model.Export;


@WebServlet(name = "listExportServlet", value = "/listExportServlet")
public class listExportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ExportDAO e = new ExportDAO();
        ArrayList<ListExport> le = e.getListExport();
        request.setAttribute("list", le);
        request.getRequestDispatcher("export/listExport.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ExportDAO e = new ExportDAO();
        ArrayList<Export> l = e.getExport();
        request.setAttribute("list", l);
        request.getRequestDispatcher("export/listExport.jsp").forward(request, response);
    }
}
