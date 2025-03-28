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
    String userId = "N/A"; 
    String eventsHTML = ""; 

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        // Fetch user_id
        String userSql = "SELECT user_id FROM Event_users WHERE username = ?";
        pst = con.prepareStatement(userSql);
        pst.setString(1, username);
        ResultSet userRs = pst.executeQuery();

        if (userRs.next()) {
            userId = userRs.getString("user_id");
        }
        userRs.close();
        pst.close();

        // Fetch user's events
        String eventSql = "SELECT event_id, event_name, location, address, city, pincode, capacity, status, event_image FROM CreateEvent WHERE user_id = ?";
        pst = con.prepareStatement(eventSql);
        pst.setString(1, userId);
        rs = pst.executeQuery();

        // Generate Bootstrap-styled event cards
        while (rs.next()) {
            String eventId = rs.getString("event_id");
            String eventName = rs.getString("event_name");
            String eventLocation = rs.getString("location");
            String address = rs.getString("address");
            String city = rs.getString("city");
            String pincode = rs.getString("pincode");
            String capacity = rs.getString("capacity");
            String status = rs.getString("status");
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
            eventsHTML += "  <div class='card h-100 event-card border-0 rounded-4 transform-hover'>";
            eventsHTML += "    <div class='card-img-wrapper position-relative overflow-hidden rounded-top-4'>";
            eventsHTML += "      <img src='" + eventImage + "' class='card-img-top event-img' alt='" + eventName + "'>";
            eventsHTML += "      <div class='overlay'></div>";
            eventsHTML += "      <span class='badge badge-glow bg-" + badgeColor + " position-absolute top-0 end-0 m-3 py-2 px-3 rounded-pill'><i class='fas fa-" + statusIcon + " me-1'></i>" + status + "</span>";
            eventsHTML += "    </div>";
            eventsHTML += "    <div class='card-body d-flex flex-column p-4'>";
            eventsHTML += "      <h5 class='card-title fw-bold mb-3'>" + eventName + "</h5>";
            eventsHTML += "      <div class='event-info mb-3'>";
            eventsHTML += "        <p class='card-text mb-2'><i class='fas fa-map-marker-alt me-2 text-primary'></i>" + eventLocation + ", " + city + " - " + pincode + "</p>";
            eventsHTML += "        <p class='card-text mb-2'><i class='fas fa-users me-2 text-primary'></i>" + capacity + " attendees</p>";
            eventsHTML += "        <p class='card-text'><i class='fas fa-home me-2 text-primary'></i>" + address + "</p>";
            eventsHTML += "      </div>";
            eventsHTML += "      <div class='mt-auto d-flex justify-content-between gap-2'>";
            eventsHTML += "        <a href='eventDetails.jsp?eventId=" + eventId + "' class='btn btn-gradient-primary flex-grow-1'><i class='fas fa-eye me-2'></i>View</a>";
            eventsHTML += "        <a href='editEvent.jsp?eventId=" + eventId + "' class='btn btn-gradient-secondary flex-grow-1'><i class='fas fa-edit me-2'></i>Edit</a>";
            eventsHTML += "        <button class='btn btn-gradient-danger flex-grow-1 delete-btn' data-event-id='" + eventId + "' data-event-name='" + eventName + "'><i class='fas fa-trash-alt me-2'></i>Delete</button>";
            eventsHTML += "      </div>";
            eventsHTML += "    </div>";
            eventsHTML += "  </div>";
            eventsHTML += "</div>";
        }
        
        // If no events found
        if (eventsHTML.isEmpty()) {
            eventsHTML = "<div class='col-12'>" +
                         "  <div class='empty-state text-center p-5'>" +
                         "    <div class='empty-state-icon mb-4'><i class='fas fa-calendar-times'></i></div>" +
                         "    <h4 class='fw-bold mb-3'>No events found</h4>" +
                         "    <p class='text-muted mb-4'>You haven't created any events yet. Start organizing your first amazing event!</p>" +
                         "    <a href='createEvent.jsp' class='btn btn-gradient-primary btn-lg'><i class='fas fa-plus me-2'></i>Create Your First Event</a>" +
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
    <!-- Page Loader -->
    <div class="loader-container" id="pageLoader">
        <div class="loader"></div>
    </div>

    <div class="d-flex">
        <!-- Sidebar -->
        <div class="sidebar" id="sidebar" style="width: 250px;">
            <div class="sidebar-brand p-3 d-flex align-items-center">
                <i class="fas fa-calendar-check fs-4 me-2"></i>
                <span class="fs-4 fw-bold">EventMaster</span>
            </div>
            
            <div class="user-profile p-3 d-flex align-items-center">
                <div class="avatar-circle me-2">
                    <img src="https://ui-avatars.com/api/?name=<%= username %>&background=4361ee&color=fff" class="rounded-circle" width="40" height="40" alt="User avatar">
                </div>
                <div class="user-info">
                    <div class="fw-bold text-white"><%= username %></div>
                    <small class="text-white-50">Event Organizer</small>
                </div>
            </div>
            
            <div class="sidebar-divider"></div>
            
            <div class="sidebar-menu">
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link d-flex align-items-center" href="dashboard.jsp">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link d-flex align-items-center active" href="myEvents.jsp">
                            <i class="fas fa-calendar-alt"></i>
                            <span>My Events</span>
                            <span class="badge rounded-pill ms-auto"><%=eventsHTML.isEmpty() ? "0" : "New" %></span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link d-flex align-items-center" href="createEvent.jsp">
                            <i class="fas fa-plus-circle"></i>
                            <span>Create Event</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link d-flex align-items-center" href="registrations.jsp">
                            <i class="fas fa-ticket-alt"></i>
                            <span>Registrations</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link d-flex align-items-center" href="analytics.jsp">
                            <i class="fas fa-chart-line"></i>
                            <span>Analytics</span>
                        </a>
                    </li>
                </ul>
                
                <div class="sidebar-divider"></div>
                
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link d-flex align-items-center" href="profile.jsp">
                            <i class="fas fa-user"></i>
                            <span>Profile</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link d-flex align-items-center" href="settings.jsp">
                            <i<i class="fas fa-cog"></i>
                            <span>Settings</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link d-flex align-items-center" href="help.jsp">
                            <i class="fas fa-question-circle"></i>
                            <span>Help & Support</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link d-flex align-items-center" href="logout.jsp">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Topbar -->
            <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm mb-4 rounded-4 p-3 topbar">
                <div class="container-fluid">
                    <button class="sidebar-toggle btn btn-sm btn-light d-lg-none me-3" id="sidebarToggle">
                        <i class="fas fa-bars"></i>
                    </button>
                    
                    <div class="d-flex align-items-center">
                        <h4 class="mb-0 fw-bold text-primary d-lg-none">EventMaster</h4>
                    </div>
                    
                    <div class="d-flex align-items-center ms-auto">
                        <!-- Notifications -->
                        <div class="dropdown notification-dropdown me-3">
                            <a class="btn btn-light rounded-circle position-relative p-2" href="#" role="button" id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-bell"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">3</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="notificationDropdown">
                                <div class="notification-header d-flex justify-content-between align-items-center">
                                    <span>Notifications</span>
                                    <span class="badge bg-light text-primary rounded-pill">3 new</span>
                                </div>
                                <div class="notification-body">
                                    <a href="#" class="dropdown-item notification-item d-flex align-items-center">
                                        <div class="notification-icon">
                                            <i class="fas fa-user-plus"></i>
                                        </div>
                                        <div>
                                            <p class="notification-title mb-0">New registration</p>
                                            <p class="notification-text mb-0">Someone registered for your event</p>
                                            <small class="notification-time">3 mins ago</small>
                                        </div>
                                    </a>
                                    <a href="#" class="dropdown-item notification-item d-flex align-items-center">
                                        <div class="notification-icon" style="background-color: rgba(12, 206, 107, 0.1); color: #0cce6b;">
                                            <i class="fas fa-calendar-check"></i>
                                        </div>
                                        <div>
                                            <p class="notification-title mb-0">Event approved</p>
                                            <p class="notification-text mb-0">Your event has been approved</p>
                                            <small class="notification-time">1 hour ago</small>
                                        </div>
                                    </a>
                                    <a href="#" class="dropdown-item notification-item d-flex align-items-center">
                                        <div class="notification-icon" style="background-color: rgba(230, 57, 70, 0.1); color: #e63946;">
                                            <i class="fas fa-exclamation-circle"></i>
                                        </div>
                                        <div>
                                            <p class="notification-title mb-0">Payment reminder</p>
                                            <p class="notification-text mb-0">Complete payment for venue booking</p>
                                            <small class="notification-time">2 days ago</small>
                                        </div>
                                    </a>
                                </div>
                                <div class="notification-footer">
                                    <a href="notifications.jsp">View all notifications</a>
                                </div>
                            </div>
                        </div>
                        
                        <!-- User Dropdown -->
                        <div class="dropdown">
                            <a class="btn btn-white dropdown-toggle d-flex align-items-center" href="#" role="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <img src="https://ui-avatars.com/api/?name=<%= username %>&background=4361ee&color=fff" class="rounded-circle me-2" width="32" height="32" alt="User avatar">
                                <span class="d-none d-lg-block"><%= username %></span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow" aria-labelledby="userDropdown">
                                <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-user me-2"></i>Profile</a></li>
                                <li><a class="dropdown-item" href="settings.jsp"><i class="fas fa-cog me-2"></i>Settings</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="logout.jsp"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
            
            <!-- Page Content -->
            <div class="container-fluid">
                <div class="page-header d-flex flex-wrap justify-content-between align-items-center">
                    <div>
                        <h3 class="page-title">My Events</h3>
                        <div class="user-welcome">Welcome back, <%= username %>! Here are your created events.</div>
                    </div>
                    <a href="createEvent.jsp" class="btn btn-gradient-primary mt-3 mt-md-0">
                        <i class="fas fa-plus me-2"></i>Create New Event
                    </a>
                </div>
                
                <!-- Search and Filter -->
                <div class="row mb-4">
                    <div class="col-lg-8 col-md-6 mb-3 mb-md-0">
                        <div class="search-bar">
                            <input type="text" class="form-control" id="eventSearch" placeholder="Search for events...">
                            <i class="fas fa-search"></i>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <div class="d-flex gap-2">
                            <div class="dropdown filter-dropdown flex-grow-1">
                                <button class="btn dropdown-toggle w-100 d-flex justify-content-between align-items-center" type="button" id="statusFilterDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span>All Statuses</span>
                                    <i class="fas fa-filter"></i>
                                </button>
                                <ul class="dropdown-menu w-100" aria-labelledby="statusFilterDropdown">
                                    <li><a class="dropdown-item active filter-option" data-filter="all">All Statuses</a></li>
                                    <li><a class="dropdown-item filter-option" data-filter="active">Active</a></li>
                                    <li><a class="dropdown-item filter-option" data-filter="pending">Pending</a></li>
                                    <li><a class="dropdown-item filter-option" data-filter="draft">Draft</a></li>
                                    <li><a class="dropdown-item filter-option" data-filter="cancelled">Cancelled</a></li>
                                </ul>
                            </div>
                            <div class="dropdown filter-dropdown">
                                <button class="btn dropdown-toggle d-flex justify-content-between align-items-center" type="button" id="sortDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fas fa-sort"></i>
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="sortDropdown">
                                    <li><a class="dropdown-item sort-option" data-sort="name-asc">Name (A-Z)</a></li>
                                    <li><a class="dropdown-item sort-option" data-sort="name-desc">Name (Z-A)</a></li>
                                    <li><a class="dropdown-item sort-option" data-sort="status">Status</a></li>
                                    <li><a class="dropdown-item sort-option" data-sort="capacity">Capacity</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Events List -->
                <div class="row" id="eventsList">
                    <%= eventsHTML %>
                </div>
            </div>
            
            <!-- Create Event Button (Mobile) -->
            <a href="createEvent.jsp" class="btn btn-create d-md-none animate__animated animate__fadeInUp">
                <i class="fas fa-plus me-2"></i>Create Event
            </a>
        </div>
    </div>
    
    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteEventModal" tabindex="-1" aria-labelledby="deleteEventModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteEventModalLabel">Confirm Deletion</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete the event <strong id="eventNameToDelete"></strong>?</p>
                    <p class="text-danger"><i class="fas fa-exclamation-triangle me-2"></i>This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteEventForm" method="post" action="deleteEvent.jsp">
                        <input type="hidden" id="eventIdToDelete" name="eventId">
                        <button type="submit" class="btn btn-gradient-danger">Delete Event</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Page loader
            setTimeout(function() {
                $("#pageLoader").fadeOut(500);
            }, 500);
            
            // Sidebar toggle for mobile
            $("#sidebarToggle").click(function() {
                $("#sidebar").toggleClass("show");
            });
            
            // Close sidebar when clicking outside on mobile
            $(document).click(function(event) {
                if ($("#sidebar").hasClass("show") && !$(event.target).closest("#sidebar").length && !$(event.target).closest("#sidebarToggle").length) {
                    $("#sidebar").removeClass("show");
                }
            });
            
            // Delete event functionality
            $(".delete-btn").click(function() {
                const eventId = $(this).data("event-id");
                const eventName = $(this).data("event-name");
                
                $("#eventIdToDelete").val(eventId);
                $("#eventNameToDelete").text(eventName);
                
                // Show modal
                const deleteModal = new bootstrap.Modal(document.getElementById('deleteEventModal'));
                deleteModal.show();
            });
            
            // Search functionality
            $("#eventSearch").on("keyup", function() {
                let value = $(this).val().toLowerCase();
                $(".event-card-container").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
                
                // Show empty state if no results
                checkEmptyState();
            });
            
            // Filter functionality
            $(".filter-option").click(function() {
                const filter = $(this).data("filter");
                
                // Update dropdown text
                $("#statusFilterDropdown span").text($(this).text());
                
                // Remove active class from all options
                $(".filter-option").removeClass("active");
                // Add active class to clicked option
                $(this).addClass("active");
                
                // Filter cards
                if (filter === "all") {
                    $(".event-card-container").show();
                } else {
                    $(".event-card-container").hide();
                    $(`.event-card-container[data-status='${filter}']`).show();
                }
                
                // Show empty state if no results
                checkEmptyState();
            });
            
            // Sort functionality
            $(".sort-option").click(function() {
                const sort = $(this).data("sort");
                const eventsList = $("#eventsList");
                const events = $(".event-card-container").get();
                
                events.sort(function(a, b) {
                    switch(sort) {
                        case "name-asc":
                            return $(a).find(".card-title").text().localeCompare($(b).find(".card-title").text());
                        case "name-desc":
                            return $(b).find(".card-title").text().localeCompare($(a).find(".card-title").text());
                        case "status":
                            return $(a).data("status").localeCompare($(b).data("status"));
                        case "capacity":
                            const capacityA = parseInt($(a).find(".card-text:contains('attendees')").text().match(/\d+/)[0]);
                            const capacityB = parseInt($(b).find(".card-text:contains('attendees')").text().match(/\d+/)[0]);
                            return capacityB - capacityA;
                        default:
                            return 0;
                    }
                });
                
                $.each(events, function(i, event) {
                    eventsList.append(event);
                });
            });
            
            // Function to check if we need to show empty state
            function checkEmptyState() {
                if ($(".event-card-container:visible").length === 0) {
                    // Only add if it doesn't exist
                    if ($("#noEventsFound").length === 0) {
                        $("#eventsList").append(`
                            <div id="noEventsFound" class="col-12">
                                <div class="empty-state text-center p-5">
                                    <div class="empty-state-icon mb-4"><i class="fas fa-search"></i></div>
                                    <h4 class="fw-bold mb-3">No matching events found</h4>
                                    <p class="text-muted mb-4">Try adjusting your search or filter criteria</p>
                                    <button class="btn btn-gradient-primary btn-lg reset-filters"><i class="fas fa-redo me-2"></i>Reset Filters</button>
                                </div>
                            </div>
                        `);
                    }
                } else {
                    // Remove if it exists
                    $("#noEventsFound").remove();
                }
            }
            
            // Reset filters
            $(document).on("click", ".reset-filters", function() {
                $("#eventSearch").val("");
                $(".event-card-container").show();
                $("#statusFilterDropdown span").text("All Statuses");
                $(".filter-option").removeClass("active");
                $(".filter-option[data-filter='all']").addClass("active");
                checkEmptyState();
            });
        });
    </script>
</body>
</html>