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
import java.sql.SQLException;

@WebServlet(name = "bookingAttendance", value = {"/analytic/attendance", "/analytic/attendance/"})
public class bookingAttendance extends HttpServlet {
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/analytic/bookingAttendance.jsp");

        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
            return;
        }

        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
