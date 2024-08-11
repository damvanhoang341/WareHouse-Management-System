package com.example.qlkh.Servlet.Car;

import com.example.qlkh.DAO.CarDAO;
import com.example.qlkh.model.Car;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "addCar", value = "/addCar")
public class addCar extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("Car/addCar.jsp").forward(request,response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String carName = request.getParameter("carName");
        String carOrigin = request.getParameter("carOrigin");
        String carDescription = request.getParameter("carDescription");

        // Create a new Car object
        Car car = new Car();
        car.setCarName(carName);
        car.setCarOrigin(carOrigin);
        car.setCarDescription(carDescription);

        // Assume you have a CarDAO to handle database operations
        CarDAO carDAO = new CarDAO();
        boolean success = carDAO.addCar(car); // Implement this method in your CarDAO class

        // Redirect to appropriate page based on success
        if (success) {
            response.sendRedirect("/CarIntro");
        } else {
            // Set error message or handle failure case
            request.setAttribute("error", "Không thể thêm xe. Vui lòng thử lại sau.");
            request.getRequestDispatcher("/addCar.jsp").forward(request, response); // Redirect back to add page with error
        }
    }
}
