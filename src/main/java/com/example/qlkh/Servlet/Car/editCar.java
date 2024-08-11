package com.example.qlkh.Servlet.Car;

import com.example.qlkh.DAO.CarDAO;
import com.example.qlkh.model.Car;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.concurrent.Callable;

@WebServlet(name = "editCar", value = "/editCar")
public class editCar extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CarDAO carDAO = new CarDAO();
        int id = Integer.parseInt(request.getParameter("cid"));
        request.setAttribute("car",carDAO.getCarById(id));
        request.getRequestDispatcher("Car/editCar.jsp").forward(request, response);
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CarDAO carDAO = new CarDAO();
        int id = Integer.parseInt( request.getParameter("carID"));
        String name = request.getParameter("carName");
        String origin = request.getParameter("carOrigin");
        String description = request.getParameter("carDescription");
        Car car =new Car();
        car.setCarId(id);
        car.setCarName(name);
        car.setCarOrigin(origin);
        car.setCarDescription(description);
        boolean carSuccess = carDAO.updateCar(car);
        if(carSuccess){
            response.sendRedirect("/CarIntro");
        }else{
            request.setAttribute("error","Cập nhật thất bại");
            request.getRequestDispatcher("Car/editCar.jsp").forward(request, response);
        }

    }
}
