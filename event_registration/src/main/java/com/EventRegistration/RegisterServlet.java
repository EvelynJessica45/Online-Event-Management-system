package com.EventRegistration;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Oracle Database Connection Details
    private static final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update with your DB details
    private static final String DB_USER = "SYSTEM";  // Change to your DB username
    private static final String DB_PASSWORD = "BCADB";  // Change to your DB password

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Retrieve form data
            String username = request.getParameter("username");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            String role = request.getParameter("role");

            // Password confirmation check
            if (!password.equals(confirmPassword)) {
                out.println("<script>alert('Passwords do not match!'); window.location='register.jsp';</script>");
                return;
            }

            // Hash the password using SHA-256
            String hashedPassword = hashPassword(password);

            // Insert into database
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver"); // Load Oracle JDBC Driver
                try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                    String query = "INSERT INTO Event_users (username, name, email, password, role) VALUES (?, ?, ?, ?, ?)";
                    try (PreparedStatement pst = con.prepareStatement(query)) {
                        pst.setString(1, username);
                        pst.setString(2, name);
                        pst.setString(3, email);
                        pst.setString(4, hashedPassword);
                        pst.setString(5, role);

                        int rowCount = pst.executeUpdate();
                        if (rowCount > 0) {
                            out.println("<script>alert('Registration Successful!'); window.location='login.jsp';</script>");
                        } else {
                            out.println("<script>alert('Registration Failed! Please try again.'); window.location='register.jsp';</script>");
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                out.println("<script>alert('Database Connection Error!'); window.location='register.jsp';</script>");
            }
        }
    }

    // Method to hash passwords using SHA-256
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
