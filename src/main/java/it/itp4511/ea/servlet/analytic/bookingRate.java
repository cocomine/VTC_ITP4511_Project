package it.itp4511.ea.servlet.analytic;

import it.itp4511.ea.db.dbConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

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
            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) AS `count`, v.location FROM Booking b, venue v WHERE b.venue = v.id GROUP BY v.location");
            ResultSet result = stmt.executeQuery();

            JSONArray total = new JSONArray();
            while (result.next()){
                JSONObject obj = new JSONObject();
                obj.put("count", result.getInt("count"));
                obj.put("location", result.getString("location"));
                total.put(obj);
            }

            request.setAttribute("totalRate", total.toString());
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
