package it.itp4511.ea.servlet.analytic;

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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Locale;
import java.util.stream.Collectors;

@WebServlet(name = "bookingRate", value = {"/analytic", "/analytic/"})
public class bookingRate extends HttpServlet {
    private Connection conn;
    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM", Locale.ENGLISH);
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

            /* get all venue */
            stmt = conn.prepareStatement("SELECT * FROM venue");
            result = stmt.executeQuery();

            ArrayList<VenueBean> venueList = new ArrayList<>();
            while (result.next()){
                VenueBean venue = VenueBean.getBean(result);
                venueList.add(venue);
            }
            request.setAttribute("venueList", venueList);

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

        if(!(json.has("id"))){
            response.setStatus(400);
            writer.println("{\"message\": \"Missing parameter\"}");
            return;
        }

        String id = json.getString("id");

        /* get venue book rate */
        try {
            /* Monthly */
            PreparedStatement stmt = conn.prepareStatement("SELECT MONTH(book_date) as `month`, COUNT(*) as `total`, COUNT(*) / 30 as `avg` FROM Booking WHERE venue = ? AND status = 1 GROUP BY MONTH(book_date)");
            stmt.setString(1, id);
            ResultSet result = stmt.executeQuery();

            JSONArray monthly = new JSONArray();
            while (result.next()){
                JSONObject obj = new JSONObject();
                LocalDateTime date = LocalDateTime.of(2021, result.getInt("month"), 1, 0, 0);
                obj.put("month", date.format(formatter));
                obj.put("total", result.getInt("total"));
                obj.put("avg", Math.round(result.getDouble("avg") * 100));
                monthly.put(obj);
            }

            /* Yearly */
            stmt = conn.prepareStatement("SELECT YEAR(book_date) as `year`, COUNT(*) as `total`, COUNT(*) / 365 as `avg` FROM Booking WHERE venue = ? AND status = 1 GROUP BY YEAR(book_date)");
            stmt.setString(1, id);
            result = stmt.executeQuery();

            JSONArray yearly = new JSONArray();
            while (result.next()){
                JSONObject obj = new JSONObject();
                obj.put("year", result.getString("year"));
                obj.put("total", result.getInt("total"));
                obj.put("avg", Math.round(result.getDouble("avg") * 100));
                yearly.put(obj);
            }

            /* output */
            JSONObject output = new JSONObject();
            output.put("monthly", monthly);
            output.put("yearly", yearly);
            writer.println(output);
        } catch (SQLException e) {
            e.printStackTrace();

            response.setStatus(500);
            writer.println("{\"message\": \"Database connection error\"}");
        }
    }
}
