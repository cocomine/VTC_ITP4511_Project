package it.itp4511.ea.servlet;

import it.itp4511.ea.db.dbConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.codec.digest.DigestUtils;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "register", value = {"/register", "/register/"})
public class register extends HttpServlet {

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

        // forward to register.jsp
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("register.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
        }

        /* start register */
        // get parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String C_password = request.getParameter("C_password");

        // check if all fields are filled
        if(username == null || username.isEmpty() || email == null || email.isEmpty() || phone == null || phone.isEmpty()
                || password == null || password.isEmpty() || C_password == null || C_password.isEmpty() ) {
            request.setAttribute("error_msg", "Please fill in all the fields");
            dispatcher.forward(request, response);
            return;
        }

        // check if password and confirm password are the same
        if(!password.equals(C_password)) {
            request.setAttribute("error_msg", "Password and confirm password are not the same");
            dispatcher.forward(request, response);
            return;
        }

        // check if phone number is not valid
        if(!phone.matches("[0-9]{8}")) {
            request.setAttribute("error_msg", "Phone number is not valid");
            dispatcher.forward(request, response);
            return;
        }

        // check if email is not valid
        if(!email.matches("[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}")) {
            request.setAttribute("error_msg", "Email is not valid");
            dispatcher.forward(request, response);
            return;
        }

        // password sha512 hashing
        password = DigestUtils.sha512Hex(password);

        // check if email is already taken
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM User WHERE email = ?");
            stmt.setString(1, email);

            if(stmt.executeQuery().next()) {
                // email is already taken
                request.setAttribute("error_msg", "Email is already taken");
                dispatcher.forward(request, response);
            }else{
                // email is not taken, insert record
                stmt = conn.prepareStatement("INSERT INTO User (username, email, phone, password, role) VALUES (?, ?, ?, ?, 0)");
                stmt.setString(1, username);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, password);
                stmt.executeUpdate();

                request.setAttribute("success_msg", "Registration successful, please login");
                dispatcher.forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();

            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
        }
    }
}
