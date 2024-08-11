package com.example.qlkh.Servlet.internal;


import com.example.qlkh.DAO.*;
import com.example.qlkh.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpSession;


@WebServlet(name = "RelocationServlet", value = "/RelocationServlet")
public class RelocationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDao p = new ProductDao();
        WareHouseDAO w = new WareHouseDAO();
        List<WareHouse> lw = w.getAllWarehouses();
        ArrayList<product> li = p.getAllProduct();
        request.setAttribute("list", li);
        request.setAttribute("lw", lw);
        request.getRequestDispatcher("internal/RelocationGoods.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] selectedProductIndices = request.getParameterValues("selectedProduct");


        ShipmentDAO s = new ShipmentDAO();
        int idWare = Integer.parseInt(request.getParameter("warehouse"));
        WareHouseDAO w = new WareHouseDAO();
        WareHouse nWare = w.getById(idWare);
        ArrayList<Shipment> lw = s.getShipmentById(idWare);

        request.setAttribute("lware", lw);
        request.setAttribute("nWare", nWare);

        if (selectedProductIndices == null) {
            request.setAttribute("error", "No products selected.");
            request.getRequestDispatcher("internal/RelocationGoods.jsp").forward(request, response);
            return;
        }

        List<Map<String, String>> selectedData = new ArrayList<>();

        for (String index : selectedProductIndices) {
            Map<String, String> item = new HashMap<>();
            item.put("p_id", request.getParameter("p_id[" + index + "]"));
            item.put("productCode", request.getParameter("productCode[" + index + "]"));
            item.put("product_name", request.getParameter("product_name[" + index + "]"));
            item.put("car_name", request.getParameter("car_name[" + index + "]"));
            item.put("inventory", request.getParameter("inventory[" + index + "]"));
            item.put("warehouse", request.getParameter("warehouse[" + index + "]"));
            item.put("location", request.getParameter("location[" + index + "]"));
            item.put("unit", request.getParameter("unit[" + index + "]"));
            selectedData.add(item);
        }

        request.setAttribute("selectedData", selectedData);
        request.getRequestDispatcher("internal/DoneRelocation.jsp").forward(request, response);
    }


}
