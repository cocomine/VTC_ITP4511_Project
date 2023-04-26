package it.itp4511.ea.servlet.admin.account;

import it.itp4511.ea.bean.UserBean;
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
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.stream.Collectors;

@WebServlet(name = "viewAccount", value = {"/admin/account", "/admin/account/"})
public class viewAccount extends HttpServlet {

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
        RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/account/viewAccount.jsp");

        if(conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
            return;
        }

        // get all accounts
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM User");
            ResultSet result = stmt.executeQuery();

            ArrayList<UserBean> users = new ArrayList<>();
            while(result.next()) {
                UserBean user = new UserBean();
                user.setId(result.getString("UUID"));
                user.setUsername(result.getString("username"));
                user.setEmail(result.getString("email"));
                user.setPhone(result.getString("phone"));
                user.setRole(result.getInt("role"));
                users.add(user);
            }

            request.setAttribute("accountList", users);
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

        if(json.getString("type") == null) {
            response.setStatus(400);
            writer.println("{\"message\": \"Missing parameter\"}");
            return;
        }

        /* get user detail */
        if("detail".equals(json.getString("type"))){
            String id = json.getString("id");
            if(id == null) {
                response.setStatus(400);
                writer.println("{\"message\": \"Missing parameter\"}");
                return;
            }

            try {
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM User WHERE UUID = ?");
                stmt.setString(1, id);
                ResultSet result = stmt.executeQuery();

                if(result.next()) {
                    JSONObject output = new JSONObject();
                    output.put("id", result.getString("UUID"));
                    output.put("username", result.getString("username"));
                    output.put("email", result.getString("email"));
                    output.put("phone", result.getString("phone"));
                    output.put("role", result.getInt("role"));

                    writer.println(output);
                } else {
                    response.setStatus(404);
                    writer.println("{\"message\": \"User not found\"}");
                }
            } catch (SQLException e) {
                e.printStackTrace();

                response.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }

        /* edit user */
        if("edit".equals(json.getString("type"))){

            //check parameter
            if(!(json.has("id") && json.has("username") && json.has("email") && json.has("phone") && json.has("role") && json.has("password"))) {
                response.setStatus(400);
                writer.println("{\"message\": \"Missing parameter\"}");
                return;
            }

            //get parameter
            String id = json.getString("id");
            String username = json.getString("username");
            String email = json.getString("email");
            String phone = json.getString("phone");
            String password = null;
            int role = json.getInt("role");

            //check empty
            if(id.isEmpty() || username.isEmpty() || email.isEmpty() || phone.isEmpty()) {
                response.setStatus(400);
                writer.println("{\"message\": \"Please fill in all the fields\"}");
                return;
            }

            //change password
            if(!json.isNull("password")) {
                if (!json.has("C_password")) {
                    response.setStatus(400);
                    writer.println("{\"message\": \"Missing parameter\"}");
                    return;
                }

                password = json.getString("password");
                String C_password = json.getString("C_password");

                //check password match
                if (!password.equals(C_password)) {
                    response.setStatus(400);
                    writer.println("{\"message\": \"Password not match\"}");
                    return;
                }
                password = DigestUtils.sha512Hex(password);
            }

            PreparedStatement stmt = null;
            try {
                //change password
                if(password != null) {;
                    stmt = conn.prepareStatement("UPDATE User SET username = ?, email = ?, phone = ?, role = ?, password = ? WHERE UUID = ?");
                    stmt.setString(1, username);
                    stmt.setString(2, email);
                    stmt.setString(3, phone);
                    stmt.setInt(4, role);
                    stmt.setString(5, password);
                    stmt.setString(6, id);
                }else{
                    stmt = conn.prepareStatement("UPDATE User SET username = ?, email = ?, phone = ?, role = ? WHERE UUID = ?");
                    stmt.setString(1, username);
                    stmt.setString(2, email);
                    stmt.setString(3, phone);
                    stmt.setInt(4, role);
                    stmt.setString(5, id);
                }
                int result = stmt.executeUpdate();

                if(result > 0) {
                    writer.println("{\"message\": \"Account updated\"}");
                } else {
                    response.setStatus(404);
                    writer.println("{\"message\": \"Account not found\"}");
                }
            } catch (SQLException e) {
                e.printStackTrace();

                response.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }

        /* delete user */
        if("delete".equals(json.getString("type"))){
            String id = json.getString("id");
            if(id == null) {
                response.setStatus(400);
                writer.println("{\"message\": \"Missing parameter\"}");
                return;
            }

            try {
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM User WHERE UUID = ?");
                stmt.setString(1, id);
                int result = stmt.executeUpdate();

                if(result > 0) {
                    writer.println("{\"message\": \"Account deleted\"}");
                } else {
                    response.setStatus(404);
                    writer.println("{\"message\": \"Account not found\"}");
                }
            } catch (SQLException e) {
                e.printStackTrace();

                response.setStatus(500);
                writer.println("{\"message\": \"Database connection error\"}");
            }
        }
    }
}
