package it.itp4511.ea.servlet.venue;

import it.itp4511.ea.bean.UserBean;
import it.itp4511.ea.bean.VenueBean;
import it.itp4511.ea.db.dbConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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

@WebServlet(name = "viewVenue", value = {"/venue", "/venue/"})
public class viewVenue extends HttpServlet {
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/venue/viewVenue.jsp");

        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
            return;
        }

        //get current user
        UserBean user = (UserBean) request.getAttribute("user");

        // get all venues
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM venue WHERE charge = ?");
            stmt.setString(1, user.getId());
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/json");
        String requestData = request.getReader().lines().collect(Collectors.joining());
        JSONObject json = new JSONObject(requestData);
        PrintWriter writer = response.getWriter();

        if(conn == null) {
            response.setStatus(500);
            writer.println("{\"message\": \"Database connection error\"}");
            return;
        }

        if(!(json.has("type") && json.has("id"))){
            response.setStatus(400);
            writer.println("{\"message\": \"Missing parameter\"}");
            return;
        }

        String type = json.getString("type");

        /* Delete venue */
        if(type.equals("delete")) {
            int id = json.getInt("id");
            try {
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM venue WHERE ID = ?");
                stmt.setInt(1, id);
                stmt.executeUpdate();
                writer.println("{\"message\": \"Venue deleted\"}");
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(400);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }

        /* Enable Disable Venue */
        if(type.equals("enable")){
            int id = json.getInt("id");
            boolean enable = json.getBoolean("enable");
            try {
                PreparedStatement stmt = conn.prepareStatement("UPDATE venue SET enable = ? WHERE ID = ?");
                stmt.setBoolean(1, enable);
                stmt.setInt(2, id);
                stmt.executeUpdate();
                writer.println("{\"message\": \"Venue Update\"}");
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(400);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }
    }
}
