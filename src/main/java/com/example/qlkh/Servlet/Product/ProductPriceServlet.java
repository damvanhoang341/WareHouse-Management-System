package com.example.qlkh.Servlet.Product;

import com.example.qlkh.DAO.ProductDao;
import com.example.qlkh.model.product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductPriceServlet", urlPatterns = {"/productprice"})
public class ProductPriceServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ProductDao productDao = new ProductDao();
        List<product> products = productDao.getProductPrice();
        request.setAttribute("products", products);
        request.getRequestDispatcher("product/Productprice.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
}
