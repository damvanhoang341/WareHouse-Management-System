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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet(name = "DoneRelocation", value = "/DoneRelocation")
public class DoneRelocation extends HttpServlet {

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
        Map<String, String[]> parameterMap = request.getParameterMap();
        ProductDao p = new ProductDao();
        // Process each parameter to get productId and idShipment
        for (String parameterName : parameterMap.keySet()) {
            if (parameterName.startsWith("idShipment_")) {
                String productId = parameterName.substring("idShipment_".length());
                String[] shipmentIds = parameterMap.get(parameterName);

                if (shipmentIds != null && shipmentIds.length > 0) {
                    String idShipment = shipmentIds[0];
                    p.moveProduct(Integer.parseInt(productId), Integer.parseInt(idShipment));

                }
            }
        }
        String ms = "Yêu cầu chuyển kho thành công!";
        request.setAttribute("ms", ms);
        response.sendRedirect(request.getContextPath() + "/RelocationServlet");

    }
}
