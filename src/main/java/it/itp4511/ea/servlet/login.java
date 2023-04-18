package it.itp4511.ea.servlet;

import it.itp4511.ea.db.dbConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.codec.digest.DigestUtils;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * login page servlet
 */
@WebServlet(name = "login", value = "/login")
public class login extends HttpServlet {

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
        // check if user is logged in
        if(request.getSession().getAttribute("user") != null) {
            response.sendRedirect("");
            return;
        }

        // forward to login.jsp
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("login.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("login.jsp");
        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            requestDispatcher.forward(request, response);
            return;
        }

        /* start login */
        // get parameters
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // check if all fields are filled
        if(email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error_msg", "Please fill all fields");
            requestDispatcher.forward(request, response);
            return;
        }

        // get user from db
        try{
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM User WHERE email = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                // check if password is correct
                if(rs.getString("password").equals(DigestUtils.sha256Hex(password))) {
                    // login success
                    JSONObject user = new JSONObject();
                    user.put("id", rs.getInt("UUID"));
                    user.put("username", rs.getString("username"));
                    user.put("email", rs.getString("email"));
                    user.put("phone", rs.getString("phone"));
                    user.put("role", rs.getString("role"));

                    request.getSession().setAttribute("user", user);
                    response.sendRedirect("");
                    return;
                }
            }

            // login failed
            request.setAttribute("error_msg", "Incorrect password");
            requestDispatcher.forward(request, response);
        }catch (SQLException e) {
            e.printStackTrace();

            request.setAttribute("error_msg", "Database connection error");
            requestDispatcher.forward(request, response);
        }

    }
}
