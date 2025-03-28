<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    // Validate session
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Database credentials
    final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    final String DB_USER = "SYSTEM";
    final String DB_PASSWORD = "BCADB";

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String userId = "N/A"; 
    String eventsHTML = ""; 

    try {
        // Load Oracle JDBC Driver
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Establish connection
        con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Fetch user_id from username
        String userSql = "SELECT user_id FROM Event_users WHERE username = ?";
        pst = con.prepareStatement(userSql);
        pst.setString(1, username);
        ResultSet userRs = pst.executeQuery();

        if (userRs.next()) {
            userId = userRs.getString("user_id");
        }
        userRs.close();
        pst.close();

        // Fetch all events for the user
        String eventSql = "SELECT event_id, event_name, event_location, address, city, pincode, capacity, status, event_image FROM Events WHERE user_id = ?";
        pst = con.prepareStatement(eventSql);
        pst.setString(1, userId);
        rs = pst.executeQuery();

        // Loop through results and build event cards
        while (rs.next()) {
            String eventId = rs.getString("event_id");
            String eventName = rs.getString("event_name");
            String eventLocation = rs.getString("event_location");
            String address = rs.getString("address");
            String city = rs.getString("city");
            String pincode = rs.getString("pincode");
            String capacity = rs.getString("capacity");
            String status = rs.getString("status");
            String eventImage = rs.getString("event_image"); // Assuming this stores image path or URL

            eventsHTML += "<div class='event-card'>";
            eventsHTML += "<img src='" + eventImage + "' alt='" + eventName + "' class='event-image'>";
            eventsHTML += "<h3>" + eventName + "</h3>";
            eventsHTML += "<p><strong>ID:</strong> " + eventId + "</p>";
            eventsHTML += "<p><strong>Location:</strong> " + eventLocation + "</p>";
            eventsHTML += "<p><strong>Address:</strong> " + address + "</p>";
            eventsHTML += "<p><strong>City & Pincode:</strong> " + city + " - " + pincode + "</p>";
            eventsHTML += "<p><strong>Capacity:</strong> " + capacity + " people</p>";
            eventsHTML += "<p><strong>Status:</strong> " + status + "</p>";
            eventsHTML += "<a href='eventDetails.jsp?eventId=" + eventId + "' class='details-btn'>View Details</a>";
            eventsHTML += "</div>";
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pst != null) try { pst.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (con != null) try { con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }

        .container {
            width: 80%;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        header h1 {
            font-size: 22px;
            color: #333;
        }

        .event-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .event-card {
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 15px;
            width: 280px;
            text-align: center;
            transition: transform 0.2s ease-in-out;
            position: relative;
        }

        .event-card:hover {
            transform: scale(1.05);
        }

        .event-card h3 {
            margin-bottom: 10px;
            color: #333;
        }

        .event-card p {
            font-size: 14px;
            color: #666;
            margin: 5px 0;
        }

        .event-card .event-image {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .details-btn {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 15px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: 0.3s;
        }

        .details-btn:hover {
            background: #0056b3;
        }

        .create-btn {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-weight: 500;
            transition: 0.3s;
        }

        .create-btn:hover {
            background: #218838;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>Welcome, <%= username %> (User ID: <%= userId %>)</h1>
        </header>
        <p>Manage your events below:</p>

        <!-- Create New Event button -->
        <a href="createEvent.jsp" class="create-btn">Create New Event</a>

        <a href="CreatedEvents.jsp" class="create-btn">Created Events</a>


    </div>
</body>
</html>
