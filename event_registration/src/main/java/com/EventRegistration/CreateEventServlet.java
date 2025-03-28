package com.EventRegistration;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CreateEventServlet")
public class CreateEventServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String eventName = request.getParameter("eventName");
        String location = request.getParameter("location");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String pincode = request.getParameter("pincode");
        String capacity = request.getParameter("capacity");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        String sessionStartDate = request.getParameter("sessionStartDate");
        String sessionEndDate = request.getParameter("sessionEndDate");
        
        String eventImage = request.getParameter("eventImage");

        // Get user_id from session and convert properly
        HttpSession session = request.getSession();
        Object userIdObj = session.getAttribute("user_id");

        if (userIdObj == null) {
            response.getWriter().println("Error: User ID not found in session.");
            return;
        }

        String userId = String.valueOf(userIdObj); // Convert Integer to String safely

        // Validate inputs (check for null or empty values)
        if (eventName == null || eventName.trim().isEmpty() ||
            location == null || location.trim().isEmpty() ||
            city == null || city.trim().isEmpty() ||
            pincode == null || pincode.trim().isEmpty() ||
            sessionStartDate == null || sessionStartDate.trim().isEmpty() ||
sessionEndDate == null || sessionEndDate.trim().isEmpty()) {
            
            response.getWriter().println("Error: Some required fields are missing.");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load JDBC Driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Connect to Database (Replace with actual credentials)
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "SYSTEM", "BCADB");

            // Insert query
            String sql = "INSERT INTO CreateEvent (event_name, location, address, city, pincode, capacity, status, user_id, description, session_start_date, session_end_date, event_image) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), TO_DATE(?, 'YYYY-MM-DD'), ?)";


            
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, eventName);
            stmt.setString(2, location);
            stmt.setString(3, address);
            stmt.setString(4, city);
            stmt.setString(5, pincode);
            stmt.setString(6, capacity);
            stmt.setString(7, status);
            stmt.setString(8, userId);
            stmt.setString(9, description);
            stmt.setString(10, sessionStartDate);
            stmt.setString(11, sessionEndDate);

            stmt.setString(12, eventImage);

            // Execute query
            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect("CreatedEvents.jsp");  // Ensure correct JSP file
            } else {
                response.getWriter().println("Error: Unable to create event.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database Error: " + e.getMessage());
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
