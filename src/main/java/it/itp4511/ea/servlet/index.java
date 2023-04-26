package it.itp4511.ea.servlet;

import it.itp4511.ea.bean.UserBean;
import it.itp4511.ea.bean.VenueBean;
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
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.stream.Collectors;

import static it.itp4511.ea.bean.VenueBean.getBean;

/**
 * Home page servlet
 */
@WebServlet(name = "index", value = "")
public class index extends HttpServlet {
    private Connection conn;

    public void init() {
        try {
            conn = dbConnect.getConnect(this.getServletContext());
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // forward to test.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");

        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
            return;
        }

        // get all venues
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM venue WHERE enable = 1");
            ResultSet result = stmt.executeQuery();

            ArrayList<VenueBean> venues = new ArrayList<>();
            while(result.next()) {
                VenueBean venue = getBean(result);
                venues.add(venue);
            }

            request.setAttribute("venueList", venues);
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();

            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json");
        PrintWriter writer = resp.getWriter();
        String requestData = request.getReader().lines().collect(Collectors.joining());
        JSONObject json = new JSONObject(requestData);

        if(conn == null) {
            resp.setStatus(500);
            writer.println("{\"message\": \"Missing parameter\"}");
            return;
        }

        //check parameter
        if(!(json.has("date") && json.has("template") && json.has("venue"))) {
            resp.setStatus(400);
            writer.println("{\"message\": \"Missing parameter\"}");
            return;
        }

        //get parameter
        String date = json.getString("date");
        String template = json.getString("template");
        JSONArray venue = json.getJSONArray("venue");

        //check parameter
        if(date.isEmpty() || venue.isEmpty()) {
            resp.setStatus(400);
            writer.println("{\"message\": \"Please fill in all the fields\"}");
            return;
        }

        //check datetime format
        if(!date.matches("\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}")) {
            resp.setStatus(400);
            writer.println("{\"message\": \"Invalid datetime format\"}");
            return;
        }

        // get current user
        UserBean user = (UserBean) request.getAttribute("user");
        String uuid = user.getId();

        //insert into database - booking
        try {
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO Booking (book_date, template, user) VALUES (?, ?, ?)");
            stmt.setString(1, date);
            stmt.setString(2, template);
            stmt.setString(3, uuid);
            stmt.executeUpdate();

            /*resp.setStatus(200);
            writer.println("{\"message\": \"Success\"}");*/
        } catch (SQLException e) {
            e.printStackTrace();

            resp.setStatus(500);
            writer.println("{\"message\": \"Database connection error\"}");
        }

        //insert into database - booking_venue

    }

    public void destroy() {
        try {
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
