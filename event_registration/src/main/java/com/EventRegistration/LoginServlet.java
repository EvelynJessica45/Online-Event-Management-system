package com.EventRegistration;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/loginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe"; 
    private static final String DB_USER = "SYSTEM";  
    private static final String DB_PASSWORD = "BCADB";  

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // "user" or "event_creator"

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver"); 
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            
            // Query to fetch user_id and hashed password
            String sql = "SELECT user_id, password FROM Event_users WHERE username = ? AND role = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, role);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");  // Retrieve user_id
                String storedHashedPassword = rs.getString("password");

                // Hash the entered password for comparison
                String hashedInputPassword = hashPassword(password);

                if (hashedInputPassword.equals(storedHashedPassword)) {
                    // Successful login
                    HttpSession session = request.getSession();
                    session.setAttribute("user_id", userId); // Store user_id in session
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    if ("user".equals(role)) {
                        response.sendRedirect("userDashboard.jsp");
                    } else if ("event_creator".equals(role)) {
                        response.sendRedirect("eventCreatorDashboard.jsp");
                    }
                } else {
                    response.sendRedirect("login.jsp?error=Invalid credentials");
                }
            } else {
                response.sendRedirect("login.jsp?error=Invalid credentials");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=Database error");
        }
    }

    // Hash password using SHA-256
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hashedBytes) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}
