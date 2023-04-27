package it.itp4511.ea.servlet;

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

@WebServlet(name = "yourBooking", value = {"/booking", "/booking/"})
public class yourBooking extends HttpServlet {
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("yourBooking.jsp");

        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
            return;
        }

        //get current user
        UserBean user = (UserBean) request.getAttribute("user");

        //get booking list
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT b.* FROM Booking b WHERE user = ?");
            stmt.setString(1, user.getId());
            ResultSet result = stmt.executeQuery();

            ArrayList<BookingBean> bookings = new ArrayList<>();
            while (result.next()) {
                BookingBean booking = BookingBean.getBeanWithOutUser(result);
                bookings.add(booking);

                // get venue
                stmt = conn.prepareStatement("SELECT * FROM venue v WHERE ID = ?");
                stmt.setString(1, booking.getVenue());
                ResultSet venueResult = stmt.executeQuery();
                if(venueResult.next()) {
                    VenueBean venue = getBean(venueResult);
                    booking.setVenueBean(venue);
                }
                System.out.println(booking);
            }

            request.setAttribute("bookingList", bookings);
            dispatcher.forward(request, response);
        } catch (SQLException throwables) {
            throwables.printStackTrace();

            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String contentType = request.getContentType();

        if(contentType != null && contentType.equals("application/json")) {
            response.setContentType("text/json");
            String requestData = request.getReader().lines().collect(Collectors.joining());
            response.setCharacterEncoding("UTF-8");
            JSONObject json = new JSONObject(requestData);
            PrintWriter writer = response.getWriter();

            if (conn == null) {
                response.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
                return;
            }

            if (!(json.has("type") && json.has("id"))) {
                response.setStatus(400);
                writer.println("{\"message\": \"Missing parameter\"}");
                return;
            }

            String type = json.getString("type");
            int id = json.getInt("id");

            /* get booking detail */
            if (type.equals("detail")) {
                try {
                    PreparedStatement stmt = conn.prepareStatement("SELECT book_date, template FROM Booking WHERE ID = ?");
                    stmt.setInt(1, id);
                    ResultSet result = stmt.executeQuery();

                    if (result.next()) {
                        JSONObject res = new JSONObject();
                        res.put("date", result.getString("book_date"));
                        res.put("template", result.getString("template"));
                        writer.println(res);
                    } else {
                        response.setStatus(404);
                        writer.println("{\"message\": \"Booking not found\"}");
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                    response.setStatus(500);
                    writer.println("{\"message\": \"Database connection error\"}");
                }
            }

            /* get booking guest list */
            if(type.equals("guestList")){
                try {
                    PreparedStatement stmt = conn.prepareStatement("SELECT guest FROM Booking WHERE ID = ?");
                    stmt.setInt(1, id);
                    ResultSet result = stmt.executeQuery();

                    if (result.next()) {
                        writer.println(result.getString("guest"));
                    } else {
                        response.setStatus(404);
                        writer.println("{\"message\": \"Booking not found\"}");
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                    response.setStatus(500);
                    writer.println("{\"message\": \"Database connection error\"}");
                }
            }

            /* update guest list */
            if(type.equals("updateGuest")){
                try {
                    PreparedStatement stmt = conn.prepareStatement("UPDATE Booking SET guest = ? WHERE ID = ?");
                    stmt.setString(1, json.getJSONArray("guest").toString());
                    stmt.setInt(2, id);
                    stmt.executeUpdate();

                    writer.println("{\"message\": \"Update Guest List success\"}");
                } catch (SQLException ex) {
                    ex.printStackTrace();
                    response.setStatus(500);
                    writer.println("{\"message\": \"Database connection error\"}");
                }
            }
        }else{
            /* update booking */
            if(conn == null) {
                request.setAttribute("error_msg", "Database connection error");
                doGet(request, response);
                return;
            }

            //get parameter
            String id = request.getParameter("id");
            String date = request.getParameter("date");
            String template = request.getParameter("template");

            //check parameter
            if(id == null || date == null || template == null){
                request.setAttribute("error_msg", "Missing parameter");
                doGet(request, response);
                return;
            }

            //check empty
            if(id.isEmpty() || date.isEmpty()){
                request.setAttribute("error_msg", "Please fill in all the fields");
                doGet(request, response);
                return;
            }

            //get current user
            UserBean user = (UserBean) request.getAttribute("user");

            //update booking
            try {
                PreparedStatement stmt = conn.prepareStatement("UPDATE Booking SET book_date = ?, template = ? WHERE ID = ? AND user = ?");
                stmt.setString(1, date);
                stmt.setString(2, template);
                stmt.setString(3, id);
                stmt.setString(4, user.getId());
                stmt.executeUpdate();

                request.setAttribute("success_msg", "Booking updated");
                doGet(request, response);
            } catch (SQLException ex) {
                ex.printStackTrace();

                request.setAttribute("error_msg", "Database connection error");
                doGet(request, response);
            }
        }
    }
}
