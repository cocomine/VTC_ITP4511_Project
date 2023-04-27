package it.itp4511.ea.servlet.analytic;

import it.itp4511.ea.bean.UserBean;
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

@WebServlet(name = "bookingAttendance", value = {"/analytic/attendance", "/analytic/attendance/"})
public class bookingAttendance extends HttpServlet {
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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/analytic/bookingAttendance.jsp");

        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
            return;
        }

        //get all members
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM User WHERE role = 0");
            ResultSet result = stmt.executeQuery();

            ArrayList<UserBean> userList = new ArrayList<>();
            while (result.next()){
                UserBean user = UserBean.getBean(result);
                userList.add(user);
            }

            request.setAttribute("userList", userList);
            dispatcher.forward(request, response);
        } catch (SQLException ex) {
            ex.printStackTrace();

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

        /* get user attendance rate */
        try {
            /* Monthly */
            PreparedStatement stmt = conn.prepareStatement("SELECT MONTH(book_date) AS `month`, COUNT(*) AS `total`, " +
                    "(SELECT COUNT(*) FROM Booking b2 WHERE b2.user = b1.user AND MONTH(b2.book_date) = month AND YEAR(b2.book_date) = YEAR(CURRENT_DATE) AND b2.check_out IS NOT NULL GROUP BY MONTH(b2.book_date)) AS `attendance`, " +
                    "(SELECT COUNT(*) FROM Booking b2 WHERE b2.user = b1.user AND MONTH(b2.book_date) = month AND YEAR(b2.book_date) = YEAR(CURRENT_DATE) AND b2.check_out IS NOT NULL GROUP BY MONTH(b2.book_date)) / COUNT(*) AS `avg` " +
                    "FROM Booking b1 WHERE b1.user = ? AND YEAR(book_date) = YEAR(CURRENT_DATE) AND b1.status = 1 GROUP BY MONTH(book_date)");
            stmt.setString(1, id);
            ResultSet result = stmt.executeQuery();

            JSONArray monthly = new JSONArray();
            while (result.next()){
                JSONObject obj = new JSONObject();
                LocalDateTime date = LocalDateTime.of(2021, result.getInt("month"), 1, 0, 0);
                obj.put("month", date.format(formatter));
                obj.put("total", result.getInt("total"));
                obj.put("attendance", result.getInt("attendance"));
                obj.put("avg", Math.round(result.getDouble("avg") * 100));
                monthly.put(obj);
            }

            /* Yearly */
            stmt = conn.prepareStatement("SELECT YEAR(book_date) AS `year`, COUNT(*) AS `total`, " +
                    "(SELECT COUNT(*) FROM Booking b2 WHERE b2.user = b1.user AND YEAR(b2.book_date) = year AND b2.check_out IS NOT NULL GROUP BY YEAR(b2.book_date)) AS `attendance`, " +
                    "(SELECT COUNT(*) FROM Booking b2 WHERE b2.user = b1.user AND YEAR(b2.book_date) = year AND b2.check_out IS NOT NULL GROUP BY YEAR(b2.book_date)) / COUNT(*) AS `avg` " +
                    "FROM Booking b1 WHERE b1.user = ? AND b1.status = 1 GROUP BY YEAR(book_date)");
            stmt.setString(1, id);
            result = stmt.executeQuery();

            JSONArray yearly = new JSONArray();
            while (result.next()){
                JSONObject obj = new JSONObject();
                obj.put("year", result.getString("year"));
                obj.put("total", result.getInt("total"));
                obj.put("attendance", result.getInt("attendance"));
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
