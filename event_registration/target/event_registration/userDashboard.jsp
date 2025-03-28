<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    final String DB_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    final String DB_USER = "system";
    final String DB_PASSWORD = "BCADB";

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
    String eventsHTML = "";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Fetch all events regardless of user_id, including description, session dates
        String eventSql = "SELECT event_id, event_name, location, address, city, pincode, status, description, session_start_date, session_end_date, event_image FROM CreateEvent";
        pst = con.prepareStatement(eventSql);
        rs = pst.executeQuery();

        // Generate Bootstrap-styled event cards
        while (rs.next()) {
            String eventId = rs.getString("event_id");
            String eventName = rs.getString("event_name");
            String eventLocation = rs.getString("location");
            String address = rs.getString("address");
            String city = rs.getString("city");
            String pincode = rs.getString("pincode");
            String status = rs.getString("status");
            String description = rs.getString("description");
            String sessionStartDate = rs.getString("session_start_date");
            String sessionEndDate = rs.getString("session_end_date");
            String eventImage = rs.getString("event_image");

            // Status badge color based on status
            String badgeColor = "success";
            String statusIcon = "check-circle";
            if (status.equalsIgnoreCase("cancelled")) {
                badgeColor = "danger";
                statusIcon = "times-circle";
            } else if (status.equalsIgnoreCase("pending")) {
                badgeColor = "warning";
                statusIcon = "clock";
            } else if (status.equalsIgnoreCase("draft")) {
                badgeColor = "info";
                statusIcon = "edit";
            }

            eventsHTML += "<div class='col-lg-4 col-md-6 col-sm-12 mb-4 event-card-container' data-status='" + status.toLowerCase() + "'>";
            eventsHTML += " <div class='card h-100 event-card border-0 rounded-4 transform-hover'>";
            eventsHTML += "  <div class='card-img-wrapper position-relative overflow-hidden rounded-top-4'>";
            eventsHTML += "   <img src='" + eventImage + "' class='card-img-top event-img' alt='" + eventName + "'>";
            eventsHTML += "   <div class='overlay'></div>";
            eventsHTML += "   <span class='badge badge-glow bg-" + badgeColor + " position-absolute top-0 end-0 m-3 py-2 px-3 rounded-pill'><i class='fas fa-" + statusIcon + " me-1'></i>" + status + "</span>";
            eventsHTML += "  </div>";
            eventsHTML += "  <div class='card-body d-flex flex-column p-4'>";
            eventsHTML += "   <h5 class='card-title fw-bold mb-3'>" + eventName + "</h5>";
            eventsHTML += "   <div class='event-info mb-3'>";
            eventsHTML += "    <p class='card-text mb-1'><i class='fas fa-map-marker-alt me-2 text-primary'></i>" + eventLocation + ", " + city + " - " + pincode + "</p>";
            eventsHTML += "    <p class='card-text mb-1'><i class='fas fa-home me-2 text-primary'></i>" + address + "</p>";
            eventsHTML += "    <p class='card-text mb-1'><i class='fas fa-calendar-alt me-2 text-primary'></i>Start: " + sessionStartDate + "</p>";
            eventsHTML += "    <p class='card-text mb-1'><i class='fas fa-calendar-alt me-2 text-primary'></i>End: " + sessionEndDate + "</p>";
            eventsHTML += "    <p class='card-text mb-2'><i class='fas fa-file-alt me-2 text-primary'></i>" + description + "</p>";

            eventsHTML += "   </div>";
            eventsHTML += "   <div class='mt-auto d-flex justify-content-center gap-2'>";
            eventsHTML += "    <a href='attendEvent.jsp?eventId=" + eventId + "' class='btn btn-gradient-primary flex-grow-1'><i class='fas fa-ticket-alt me-2'></i>Attend Event</a>";
            eventsHTML += "   </div>";
            eventsHTML += "  </div>";
            eventsHTML += " </div>";
            eventsHTML += "</div>";
        }

        // If no events found
        if (eventsHTML.isEmpty()) {
            eventsHTML = "<div class='col-12'>" +
                         "  <div class='empty-state text-center p-5'>" +
                         "   <div class='empty-state-icon mb-4'><i class='fas fa-calendar-times'></i></div>" +
                         "   <h4 class='fw-bold mb-3'>No events found</h4>" +
                         "   <p class='text-muted mb-4'>No events have been created yet.</p>" +
                         "   <a href='createEvent.jsp' class='btn btn-gradient-primary btn-lg'><i class='fas fa-plus me-2'></i>Create Your First Event</a>" +
                         "  </div>" +
                         "</div>";
        }
    } catch (Exception e) {
        eventsHTML = "<div class='col-12'><div class='alert alert-danger shadow-lg'><i class='fas fa-exclamation-triangle me-2'></i>Error loading events: " + e.getMessage() + "</div></div>";
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
    <title>My Events | Event Management Dashboard</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
<style>
        :root {
            --primary: #4361ee;
            --primary-light: #4895ef;
            --primary-dark: #3f37c9;
            --secondary: #6c757d;
            --success: #0cce6b;
            --danger: #e63946;
            --warning: #ffbe0b;
            --info: #4cc9f0;
            --light: #f8f9fa;
            --dark: #212529;
            --white: #ffffff;
            --gradient-1: linear-gradient(45deg, #4361ee, #4895ef);
            --gradient-2: linear-gradient(45deg, #f72585, #b5179e);
            --gradient-3: linear-gradient(45deg, #0cce6b, #06d6a0);
            --gradient-4: linear-gradient(45deg, #ffbe0b, #fb8500);
            --transition: all 0.3s ease;
            --shadow-sm: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            --shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            --shadow-lg: 0 1rem 3rem rgba(0, 0, 0, 0.175);
            --border-radius: 0.5rem;
            --border-radius-lg: 1rem;
        }
        
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f2f5;
            color: #495057;
            overflow-x: hidden;
        }
        
        .btn {
            border-radius: 10px;
            font-weight: 500;
            padding: 0.6rem 1.2rem;
            transition: var(--transition);
            border: none;
            letter-spacing: 0.3px;
        }
        
        .btn-gradient-primary {
            background: var(--gradient-1);
            color: white;
        }
        
        .btn-gradient-primary:hover {
            background: linear-gradient(45deg, #3f37c9, #4361ee);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
        
        .btn-gradient-secondary {
            background: linear-gradient(45deg, #6c757d, #495057);
            color: white;
        }
        
        .btn-gradient-secondary:hover {
            background: linear-gradient(45deg, #495057, #343a40);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.3);
        }
        
        .btn-gradient-danger {
            background: linear-gradient(45deg, #e63946, #d62828);
            color: white;
        }
        
        .btn-gradient-danger:hover {
            background: linear-gradient(45deg, #d62828, #c1121f);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(230, 57, 70, 0.3);
        }
        
        .badge {
            font-weight: 500;
            letter-spacing: 0.5px;
            padding: 0.5em 0.8em;
        }
        
        .badge-glow {
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        
        /* Sidebar Styles */
        .sidebar {
            min-height: 100vh;
            background: var(--dark);
            color: var(--white);
            transition: var(--transition);
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
        }
        
        .sidebar-brand {
            padding: 1.5rem;
            background: var(--primary-dark);
            background: var(--gradient-1);
        }
        
        .sidebar-menu {
            padding: 1rem 0;
        }
        
        .sidebar .nav-link {
            color: rgba(255, 255, 255, 0.8);
            padding: 1rem 1.5rem;
            font-weight: 500;
            border-left: 4px solid transparent;
            transition: var(--transition);
            margin: 0.2rem 0;
        }
        
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            color: var(--white);
            background-color: rgba(255, 255, 255, 0.1);
            border-left: 4px solid var(--primary-light);
        }
        
        .sidebar .nav-link i {
            margin-right: 0.8rem;
            width: 24px;
            text-align: center;
            font-size: 1.1rem;
        }
        
        .sidebar .badge {
            margin-left: auto;
            background: rgba(255, 255, 255, 0.2);
        }
        
        .sidebar-divider {
            height: 1px;
            background-color: rgba(255, 255, 255, 0.1);
            margin: 1rem 0;
        }
        
        .sidebar .dropdown-menu {
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            border: none;
            margin-top: 0.5rem;
            background-color: var(--dark);
        }
        
        .sidebar .dropdown-item {
            color: rgba(255, 255, 255, 0.8);
            padding: 0.7rem 1.5rem;
            transition: var(--transition);
        }
        
        .sidebar .dropdown-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: var(--white);
        }
        
        /* Content Styles */
        .main-content {
            padding: 30px;
            transition: var(--transition);
            margin-left: 250px;
        }
        
        .page-header {
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        
        .page-title {
            font-weight: 700;
            margin-bottom: 0.5rem;
            background: var(--gradient-1);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: inline-block;
        }
        
        .user-welcome {
            font-size: 1rem;
            color: var(--secondary);
            margin-top: 0.5rem;
        }
        
        /* Search and Filter */
        .search-bar {
            position: relative;
        }
        
        .search-bar .form-control {
            border-radius: 50px;
            padding-left: 45px;
            padding-right: 20px;
            height: 50px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }
        
        .search-bar .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
            border-color: var(--primary-light);
        }
        
        .search-bar i {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--secondary);
        }
        
        .filter-dropdown .dropdown-toggle {
            border-radius: 50px;
            padding: 0.8rem 1.5rem;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(0, 0, 0, 0.1);
            transition: var(--transition);
            background: white;
        }
        
        .filter-dropdown .dropdown-toggle:hover,
        .filter-dropdown .dropdown-toggle:focus {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        .filter-dropdown .dropdown-menu {
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            border: none;
            margin-top: 0.5rem;
            padding: 0.5rem;
        }
        
        .filter-dropdown .dropdown-item {
            border-radius: var(--border-radius);
            padding: 0.6rem 1rem;
            transition: var(--transition);
            margin: 0.2rem 0;
        }
        
        .filter-dropdown .dropdown-item.active {
            background-color: var(--primary);
        }
        
        .filter-dropdown .dropdown-item:hover {
            background-color: rgba(67, 97, 238, 0.1);
            color: var(--primary);
        }
        
        /* Event Cards */
        .event-card {
            transition: var(--transition);
            background: white;
            box-shadow: var(--shadow-sm);
            border-radius: var(--border-radius-lg) !important;
        }
        
        .transform-hover:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow) !important;
        }
        
        .card-img-wrapper {
            height: 200px;
            overflow: hidden;
        }
        
        .event-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.8s ease;
        }
        
        .event-card:hover .event-img {
            transform: scale(1.1);
        }
        
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(to bottom, rgba(0,0,0,0) 50%, rgba(0,0,0,0.7) 100%);
            z-index: 1;
        }
        
        .card-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: var(--dark);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            position: relative;
        }
        
        .card-title::after {
            content: '';
            display: block;
            width: 30%;
            height: 3px;
            background: var(--gradient-1);
            margin-top: 10px;
            border-radius: 50px;
        }
        
        .event-info {
            font-size: 0.9rem;
        }
        
        .event-info i {
            width: 20px;
            text-align: center;
        }
        
        /* Create Event Button */
        .btn-create {
            position: fixed;
            bottom: 30px;
            right: 30px;
            border-radius: 50px;
            padding: 1rem 2rem;
            font-weight: 600;
            background: var(--gradient-3);
            color: white;
            box-shadow: 0 5px 20px rgba(12, 206, 107, 0.4);
            border: none;
            z-index: 1000;
            transition: var(--transition);
        }
        
        .btn-create:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 8px 25px rgba(12, 206, 107, 0.6);
            color: white;
        }
        
        .btn-create i {
            transition: transform 0.3s;
        }
        
        .btn-create:hover i {
            transform: rotate(90deg);
        }
        
        /* Empty State */
        .empty-state {
            background: white;
            border-radius: var(--border-radius-lg);
            padding: 3rem !important;
            box-shadow: var(--shadow-sm);
        }
        
        .empty-state-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 80px;
            height: 80px;
            background: rgba(67, 97, 238, 0.1);
            border-radius: 50%;
            font-size: 2rem;
            color: var(--primary);
        }
        
        /* Modal Customization */
        .modal-content {
            border: none;
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-lg);
        }
        
        .modal-header {
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            background: var(--gradient-1);
            color: white;
            border-radius: calc(var(--border-radius-lg) - 1px) calc(var(--border-radius-lg) - 1px) 0 0;
        }
        
        .modal-footer {
            border-top: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        .modal-backdrop.show {
            opacity: 0.7;
        }
        
        /* Animations */
        .animated-icon {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }
        
        /* Loader */
        .loader-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.8);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        
        .loader {
            width: 48px;
            height: 48px;
            border: 5px solid var(--primary);
            border-bottom-color: transparent;
            border-radius: 50%;
            animation: rotation 1s linear infinite;
        }
        
        @keyframes rotation {
            0% {
                transform: rotate(0deg);
            }
            100% {
                transform: rotate(360deg);
            }
        }
        
        /* Notifications */
        .dropdown-menu-end {
            right: 0;
            left: auto;
        }
        
        .notification-dropdown .dropdown-menu {
            width: 320px;
            padding: 0;
            overflow: hidden;
        }
        
        .notification-header {
            background: var(--gradient-1);
            color: white;
            padding: 1rem;
            font-weight: 500;
        }
        
        .notification-body {
            max-height: 300px;
            overflow-y: auto;
        }
        
        .notification-item {
            padding: 1rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            transition: var(--transition);
        }
        
        .notification-item:hover {
            background-color: rgba(0, 0, 0, 0.05);
        }
        
        .notification-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary);
            margin-right: 1rem;
        }
        
        .notification-title {
            font-weight: 500;
            margin-bottom: 0.25rem;
        }
        
        .notification-time {
            font-size: 0.75rem;
            color: var(--secondary);
        }
        
        .notification-footer {
            padding: 0.75rem 1rem;
            background-color: #f8f9fa;
            text-align: center;
            font-weight: 500;
        }
        
        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }
        
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 10px;
        }
        
        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }
        
        /* Media Queries */
        @media (max-width: 992px) {
            .sidebar {
                width: 75px !important;
                overflow: hidden;
                white-space: nowrap;
            }
            
            .sidebar .nav-link span,
            .sidebar .badge,
            .sidebar-brand span {
                display: none;
            }
            
            .sidebar .nav-link {
                padding: 1rem;
                text-align: center;
            }
            
            .sidebar .nav-link i {
                margin-right: 0;
                font-size: 1.2rem;
            }
            
            .main-content {
                margin-left: 75px;
                padding: 20px;
            }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                position: fixed;
                width: 250px !important;
            }
            
            .sidebar.show {
                transform: translateX(0);
            }
            
            .sidebar .nav-link span,
            .sidebar .badge,
            .sidebar-brand span {
                display: inline-block;
            }
            
            .main-content {
                margin-left: 0;
                padding: 15px;
            }
            
            .card-img-wrapper {
                height: 180px;
            }
            
            .btn-create {
                padding: 0.8rem 1.5rem;
                right: 20px;
                bottom: 20px;
            }
            
            .search-filter-container {
                flex-direction: column;
            }
            
            .search-bar, .filter-dropdown {
                width: 100%;
                margin-bottom: 1rem;
            }
            
            .navbar-toggler {
                display: block;
            }
        }

        /* Fix for the sidebar toggle */
        .sidebar-toggle {
            cursor: pointer;
        }

        /* Additional responsive fixes */
        .topbar {
            position: sticky;
            top: 0;
            z-index: 1020;
        }
    </style>
    </head>
<body>
    <div class="main-content">
        <div class="container-fluid">
            <div class="page-header d-flex flex-wrap justify-content-between align-items-center">
                <div>
                    <h3 class="page-title">All Events</h3>
                    <div class="user-welcome">Welcome back, <%= username %>! Here are all created events by organisers.</div>
                </div>
                
            </div>
            
            <div class="row" id="eventsList">
                <%= eventsHTML %>
            </div>
        </div>
        
        </div>
    </body>
</html>


