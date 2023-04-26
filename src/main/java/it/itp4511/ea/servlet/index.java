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
        JSONArray array = new JSONArray(requestData);

        if(conn == null) {
            resp.setStatus(500);
            writer.println("{\"message\": \"Missing parameter\"}");
            return;
        }

        //check parameter
        if(array.isEmpty()) {
            resp.setStatus(400);
            writer.println("{\"message\": \"Missing parameter\"}");
            return;
        }

        //get current user
        UserBean user = (UserBean) request.getAttribute("user");

        for(Object obj : array){
            JSONObject json = (JSONObject) obj;

            //check parameter
            if(!(json.has("detail") && json.has("guest") && json.has("venue") && json.getJSONObject("detail").has("date"))){
                resp.setStatus(400);
                writer.println("{\"message\": \"Missing parameter\"}");
                return;
            }

            // get parameter
            String date = json.getJSONObject("detail").getString("date");
            int venue = json.getJSONArray("venue").getInt(1);
            JSONArray guest = json.getJSONArray("guest");
            String template = null;
            if(!json.getJSONObject("detail").isNull("template")){
                template = json.getJSONObject("detail").getString("template");
            }

            // check empty
            if(date.isEmpty()){
                resp.setStatus(400);
                writer.println("{\"message\": \"Missing parameter\"}");
                return;
            }

            // insert into database
            try {
                PreparedStatement stmt = conn.prepareStatement("INSERT INTO Booking (user, book_date, venue, template, guest) VALUES (?, ?, ?, ?, ?)");
                stmt.setString(1, user.getId());
                stmt.setString(2, date);
                stmt.setInt(3, venue);
                stmt.setString(4, template);
                stmt.setString(5, guest.toString());
                stmt.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
                resp.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
                return;
            }
        }

        writer.println("{\"message\": \"Booking " + array.length() + " venue success\"}");
    }

    public void destroy() {
        try {
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
