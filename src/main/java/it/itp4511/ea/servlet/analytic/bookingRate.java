package it.itp4511.ea.servlet.analytic;

import it.itp4511.ea.db.dbConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name = "bookingRate", value = {"/analytic", "/analytic/"})
public class bookingRate extends HttpServlet {
    private Connection conn;

    public void init() {
        try {
            conn = dbConnect.getConnect(this.getServletContext());
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/analytic/bookingRate.jsp");

        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
            return;
        }

        //get Total Booking Rate
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*), v.location AS total FROM Booking b, venue v WHERE b.venue = v.id GROUP BY v.location");
            ResultSet result = stmt.executeQuery();


            //request.setAttribute("totalRate", total);
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();

            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
