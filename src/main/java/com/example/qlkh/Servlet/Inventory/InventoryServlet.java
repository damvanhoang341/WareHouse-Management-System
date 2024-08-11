package com.example.qlkh.Servlet.Inventory;

import com.example.qlkh.DAO.InventoryDAO;
import com.example.qlkh.DAO.WareHouseDAO;
import com.example.qlkh.model.WareHouse;
import com.example.qlkh.model.product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "InventoryServlet", urlPatterns = {"/inventory"})
public class InventoryServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        search = search != null ? search.trim().replaceAll("\\s++", " ") : "";
        String ware = request.getParameter("ware");
        int wareNumber = 0;
        try {
            wareNumber = Integer.parseInt(ware);
        } catch (Exception e) {
            wareNumber = 0;
        }
        String sort = request.getParameter("sort");
        sort = sort != null ? sort : "";
        int currentPage = 1;
        int recordsPerPage = 5;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        InventoryDAO inventoryDAO = new InventoryDAO();
        List<product> products = inventoryDAO.listProductsByPage(search, wareNumber, sort, (currentPage-1)*recordsPerPage, recordsPerPage);
        int rows = inventoryDAO.getNumberOfRows(search, wareNumber, sort);
        int totalPages = (int) Math.ceil((double) rows / recordsPerPage);

        WareHouseDAO wareDao = new WareHouseDAO();
        List<WareHouse> wares = wareDao.getAllWarehouses();

        request.setAttribute("search", search);
        request.setAttribute("ware", ware);
        request.setAttribute("sort", sort);
        request.setAttribute("wares", wares);
        request.setAttribute("products", products);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.getRequestDispatcher("inventory/inventory.jsp").forward(request, response);
    }
}
