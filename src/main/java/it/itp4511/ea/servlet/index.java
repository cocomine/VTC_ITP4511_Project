package it.itp4511.ea.servlet;

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
import java.sql.SQLException;

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
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/json");
        PrintWriter out = resp.getWriter();
        JSONObject json = new JSONObject();

        if(req.getSession().getAttribute("user") == null) {
            resp.setStatus(401);
            json.put("message", "Unauthorized");
            out.println(json);
            return;
        }

        if(conn == null) {
            resp.setStatus(500);
            json.put("message", "Internal server error");
            out.println(json);
            return;
        }

        //todo: do something

        json.put("code", 200);
        out.println(json);
    }

    public void destroy() {
        try {
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
