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
import java.util.List;
import java.util.Map;


@WebServlet(name = "ConfirmRe", value = "/ConfirmRe")
public class ConfirmRe extends HttpServlet {

        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            ProductDao p = new ProductDao();
            RelocationDAO r = new RelocationDAO();

            ArrayList<ListRelocation> lr = r.listReloca();

            request.setAttribute("lr", lr);

            request.getRequestDispatcher("internal/ListRelocation.jsp").forward(request, response);
        }

        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            int check = Integer.parseInt(request.getParameter("buttonValue"));
            int idFreight = Integer.parseInt(request.getParameter("id_freight"));
            int productId = Integer.parseInt(request.getParameter("productid"));
            int newLocation = Integer.parseInt(request.getParameter("placeNew"));


            PrintWriter out = response.getWriter();

            out.println(check);
            out.println(idFreight);
            out.println(productId);
            out.println(newLocation);
            RelocationDAO r = new RelocationDAO();

            if (check == 1) {
                r.ChangeRelocation("OK", "OK", idFreight);
                r.ChangePlace(productId, newLocation);
            } else if (check == 0) {
                r.ChangeRelocation("NOT", "OK", idFreight);
            }

            doGet(request, response);
        }
    }

