package it.itp4511.ea.servlet.venue;

import it.itp4511.ea.db.dbConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "createVenue", value = {"/venue/create", "/venue/create/"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class createVenue extends HttpServlet {

    private Connection conn;
    private String uploadPath;

    public void init() {

        //create upload folder if not exists
        uploadPath = getServletContext().getRealPath("/upload");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        try {
            conn = dbConnect.getConnect(this.getServletContext());
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/venue/createVenue.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/venue/createVenue.jsp");

        if (conn == null) {
            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
        }

        /* start create */
        // get image
        Part image = null;
        // check if image is too big
        try {
            image = request.getPart("image");
        }catch (IllegalStateException e) {
            request.setAttribute("error_msg", "Image size must be less than 5MB.");
            dispatcher.forward(request, response);
            return;
        }

        // get parameters
        String location = request.getParameter("location");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String max = request.getParameter("max");
        String fee = request.getParameter("fee");

        // check if all fields are filled
        if (location == null || name == null || description == null || max == null || fee == null || image == null || location.isEmpty() || name.isEmpty() || description.isEmpty() || max.isEmpty() || fee.isEmpty() || image.getSize() == 0) {
            request.setAttribute("error_msg", "Please fill in all fields.");
            dispatcher.forward(request, response);
            return;
        }

        // check if max and fee are numbers
        if (!max.matches("[0-9]+") || !fee.matches("[0-9]+")) {
            request.setAttribute("error_msg", "Max and fee must be numbers.");
            dispatcher.forward(request, response);
            return;
        }

        // check if max and fee are positive
        if (Integer.parseInt(max) <= 0 || Integer.parseInt(fee) < 0) {
            request.setAttribute("error_msg", "Max and fee must be positive.");
            dispatcher.forward(request, response);
            return;
        }

        // file name
        String[] image_name = image.getSubmittedFileName().split("\\.");
        String file_name = System.currentTimeMillis() + "." + image_name[image_name.length - 1];
        String image_path = uploadPath + File.separator + file_name;

        // save image to upload folder
        try (
                InputStream in = image.getInputStream();
                OutputStream out = new FileOutputStream(image_path)
        ) {
            byte[] buffer = new byte[1024];
            int length = -1;
            while ((length = in.read(buffer)) != -1) {
                out.write(buffer, 0, length);
            }
        } catch (IOException e) {
            e.printStackTrace();

            request.setAttribute("error_msg", "Error saving image.");
            dispatcher.forward(request, response);
            return;
        }

        // insert into database
        try {
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO venue (location, name, description, max, fee, image) VALUES (?, ?, ?, ?, ?, ?)");
            stmt.setString(1, location);
            stmt.setString(2, name);
            stmt.setString(3, description);
            stmt.setInt(4, Integer.parseInt(max));
            stmt.setInt(5, Integer.parseInt(fee));
            stmt.setString(6, file_name);
            stmt.executeUpdate();

            request.setAttribute("success_msg", "Venue created successfully.");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();

            request.setAttribute("error_msg", "Database connection error");
            dispatcher.forward(request, response);
        }
    }
}
