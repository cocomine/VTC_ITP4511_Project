package it.itp4511.ea.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * logout page servlet
 */
@WebServlet(name = "logout", value = "/logout")
public class logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        requestProcessing(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        requestProcessing(request, response);
    }

    private void requestProcessing(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // logout
        // invalidate session
        request.getSession().invalidate();

        // redirect to login page
        response.sendRedirect("login");
    }
}
