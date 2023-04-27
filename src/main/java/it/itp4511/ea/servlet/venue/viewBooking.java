package it.itp4511.ea.servlet.venue;

import it.itp4511.ea.bean.BookingBean;
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

@WebServlet(name = "viewBooking", value = {"/venue/booking", "/venue/booking/"})
public class viewBooking extends HttpServlet {
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/venue/viewBooking.jsp");

        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
            return;
        }

        //get current user
        UserBean user = (UserBean) request.getAttribute("user");

        // get current user venues booking
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT b.*, u.* FROM Booking b, venue v, User u WHERE b.venue = v.ID AND b.user = u.UUID AND charge = ?");
            stmt.setString(1, user.getId());
            ResultSet result = stmt.executeQuery();

            ArrayList<BookingBean> bookings = new ArrayList<>();
            while(result.next()) {
                BookingBean booking = BookingBean.getBean(result);
                bookings.add(booking);

                // get venue
                stmt = conn.prepareStatement("SELECT * FROM venue v WHERE ID = ?");
                stmt.setString(1, booking.getVenue());
                ResultSet venueResult = stmt.executeQuery();
                if(venueResult.next()) {
                    VenueBean venue = getBean(venueResult);
                    booking.setVenueBean(venue);
                }
            }

            request.setAttribute("bookingList", bookings);
            dispatcher.forward(request, response);
        }catch (SQLException e) {
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

        /* approve booking */
        if(type.equals("approve")) {
            try {
                PreparedStatement stmt = conn.prepareStatement("UPDATE Booking SET status = 1 WHERE ID = ? AND status = 0");
                stmt.setInt(1, json.getInt("id"));
                stmt.executeUpdate();

                response.setStatus(200);
                writer.println("{\"message\": \"Booking approved\"}");
            } catch (SQLException e) {
                e.printStackTrace();

                response.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }

        /* reject booking */
        else if(type.equals("reject")) {
            try {
                PreparedStatement stmt = conn.prepareStatement("UPDATE Booking SET status = 2 WHERE ID = ? AND status = 0");
                stmt.setInt(1, json.getInt("id"));
                stmt.executeUpdate();

                response.setStatus(200);
                writer.println("{\"message\": \"Booking rejected\"}");
            } catch (SQLException e) {
                e.printStackTrace();

                response.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }

        /* check-in booking */
        else if(type.equals("checkin")) {
            try {
                PreparedStatement stmt = conn.prepareStatement("UPDATE Booking SET check_in = CURRENT_TIMESTAMP WHERE ID = ? AND status = 1");
                stmt.setInt(1, json.getInt("id"));
                stmt.executeUpdate();

                response.setStatus(200);
                writer.println("{\"message\": \"Booking checked-in\"}");
            } catch (SQLException e) {
                e.printStackTrace();

                response.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }

        /* check-out booking */
        else if(type.equals("checkout")) {
            try {
                PreparedStatement stmt = conn.prepareStatement("UPDATE Booking SET check_out = CURRENT_TIMESTAMP WHERE ID = ? AND status = 1");
                stmt.setInt(1, json.getInt("id"));
                stmt.executeUpdate();

                response.setStatus(200);
                writer.println("{\"message\": \"Booking checked-out\"}");
            } catch (SQLException e) {
                e.printStackTrace();

                response.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }

        /* view guest list */
        else if(type.equals("guestlist")) {
            try {
                PreparedStatement stmt = conn.prepareStatement("SELECT guest, template FROM Booking WHERE ID = ?");
                stmt.setInt(1, json.getInt("id"));
                ResultSet result = stmt.executeQuery();

                if(result.next()) {
                    JSONArray guestList = new JSONArray(result.getString("guest"));
                    String template = result.getString("template");
                    response.setStatus(200);

                    JSONObject output = new JSONObject();
                    output.put("template", template);
                    output.put("guest", guestList);
                    writer.println(output);
                } else {
                    response.setStatus(404);
                    writer.println("{\"message\": \"Booking not found\"}");
                }
            } catch (SQLException e) {
                e.printStackTrace();

                response.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }
    }
}
