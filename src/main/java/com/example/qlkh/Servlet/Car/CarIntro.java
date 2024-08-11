package com.example.qlkh.Servlet.Car;

import com.example.qlkh.DAO.CarDAO;
import com.example.qlkh.model.Car;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CarIntro", value = "/CarIntro")
public class CarIntro extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CarDAO carDAO = new CarDAO();
        request.setAttribute("car",carDAO.getAllCar());
        request.getRequestDispatcher("Car/carIntro.jsp").forward(request, response);
    }
}
