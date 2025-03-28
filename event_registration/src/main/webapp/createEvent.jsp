    <%-- <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Event - Galaxy Edition</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #8B5CF6;
                --secondary-color: #C4B5FD;
                --accent-color: #7C3AED;
                --dark-bg: #0F172A;
                --card-bg: rgba(30, 41, 59, 0.8);
                --border-color: rgba(148, 163, 184, 0.2);
                --text-primary: #F8FAFC;
                --text-secondary: #CBD5E1;
                --text-muted: #94A3B8;
                --success-color: #10B981;
                --input-bg: rgba(15, 23, 42, 0.6);
                --shadow-color: rgba(139, 92, 246, 0.3);
                --border-radius: 12px;
                --box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
                --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            /* Main Elements */
            body {
                background: linear-gradient(135deg, #0F172A, #1E293B, #334155);
                background-attachment: fixed;
                color: var(--text-primary);
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 20px;
                min-height: 100vh;
                position: relative;
                overflow-x: hidden;
            }

            body::before {
                content: '';
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: 
                    radial-gradient(circle at 20% 35%, rgba(139, 92, 246, 0.15) 0%, transparent 50%),
                    radial-gradient(circle at 80% 10%, rgba(139, 92, 246, 0.1) 0%, transparent 50%);
                pointer-events: none;
                z-index: -1;
            }

            .stars {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: -1;
            }

            .star {
                position: absolute;
                background-color: white;
                border-radius: 50%;
                opacity: 0.6;
                animation: twinkle 5s infinite ease-in-out;
            }

            @keyframes twinkle {
                0%, 100% { opacity: 0.2; }
                50% { opacity: 0.7; }
            }

            /* Container Styling */
            .container {
                max-width: 800px;
                width: 100%;
                margin: 20px auto;
                background: var(--card-bg);
                backdrop-filter: blur(10px);
                border: 1px solid var(--border-color);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 40px;
                position: relative;
                overflow: hidden;
                z-index: 1;
            }

            .container::before {
                content: '';
                position: absolute;
                top: -2px;
                left: -2px;
                right: -2px;
                bottom: -2px;
                background: linear-gradient(45deg, var(--primary-color), transparent, var(--primary-color));
                z-index: -1;
                transform: scale(1.05);
                filter: blur(20px);
                opacity: 0.3;
                transition: var(--transition);
                border-radius: inherit;
            }

            .container:hover::before {
                opacity: 0.4;
                animation: border-flow 3s infinite alternate;
            }

            @keyframes border-flow {
                0% { background-position: 0% 50%; }
                100% { background-position: 100% 50%; }
            }

            /* Header Styling */
            h2 {
                font-size: 28px;
                color: var(--text-primary);
                margin-bottom: 30px;
                text-align: center;
                font-weight: 600;
                letter-spacing: 0.5px;
                text-transform: uppercase;
                background: linear-gradient(to right, var(--text-primary), var(--secondary-color));
                -webkit-background-clip: text;
                background-clip: text;
                color: transparent;
            }

            /* Form Styling */
            form {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            .form-group {
                position: relative;
                margin-bottom: 5px;
            }

            .form-group.full-width {
                grid-column: span 2;
            }

            label {
                display: block;
                font-size: 14px;
                margin-bottom: 8px;
                color: var(--secondary-color);
                font-weight: 500;
                transition: var(--transition);
            }

            input, select, textarea {
                width: 100%;
                padding: 12px 15px;
                background: var(--input-bg);
                border: 1px solid var(--border-color);
                border-radius: 8px;
                color: var(--text-primary);
                font-size: 15px;
                transition: var(--transition);
                font-family: inherit;
                box-sizing: border-box;
            }

            input:focus, select:focus, textarea:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 3px var(--shadow-color);
            }

            input::placeholder, textarea::placeholder {
                color: var(--text-muted);
            }

            textarea {
                resize: vertical;
                min-height: 100px;
            }

            /* Icon styling */
            .input-with-icon {
                position: relative;
            }

            .input-icon {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                left: 12px;
                color: var(--secondary-color);
                font-size: 16px;
            }

            .input-with-icon input,
            .input-with-icon select {
                padding-left: 40px;
            }

            /* Button styling */
            .btn-container {
                grid-column: span 2;
                margin-top: 10px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            button {
                background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
                color: white;
                border: none;
                border-radius: 30px;
                padding: 14px 30px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: var(--transition);
                box-shadow: 0 4px 20px rgba(124, 58, 237, 0.3);
                position: relative;
                overflow: hidden;
                z-index: 1;
                font-family: inherit;
            }

            button::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: all 0.6s;
                z-index: -1;
            }

            button:hover {
                transform: translateY(-3px);
                box-shadow: 0 7px 25px rgba(124, 58, 237, 0.5);
            }

            button:hover::before {
                left: 100%;
            }

            .btn-secondary {
                background: transparent;
                border: 1px solid var(--secondary-color);
                color: var(--secondary-color);
                box-shadow: none;
            }

            .btn-secondary:hover {
                background: rgba(139, 92, 246, 0.1);
                box-shadow: 0 4px 15px rgba(139, 92, 246, 0.15);
            }

            /* Responsive styling */
            @media (max-width: 768px) {
                .container {
                    padding: 25px;
                    width: 90%;
                }

                form {
                    grid-template-columns: 1fr;
                }

                .form-group.full-width {
                    grid-column: span 1;
                }

                .btn-container {
                    grid-column: span 1;
                    flex-direction: column;
                    gap: 15px;
                }

                button {
                    width: 100%;
                }

                h2 {
                    font-size: 24px;
                }
            }

            /* Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .container {
                animation: fadeIn 0.6s ease-out forwards;
            }

            /* Custom select styling */
            select {
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23C4B5FD' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 16px;
            }
        </style>
    </head>
    <body>
        <!-- Stars background -->
        <div class="stars" id="stars"></div>
        
        <div class="container">
            <h2>Create New Galaxy Event</h2>
            <form action="CreateEventServlet" method="post">
                <div class="form-group">
                    <label for="eventName">Event Name</label>
                    <div class="input-with-icon">
                        <i class="fas fa-calendar-alt input-icon"></i>
                        <input type="text" id="eventName" name="eventName" placeholder="Enter event name" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="location">Location</label>
                    <div class="input-with-icon">
                        <i class="fas fa-map-marker-alt input-icon"></i>
                        <input type="text" id="location" name="location" placeholder="Enter location name" required>
                    </div>
                </div>

                <div class="form-group full-width">
                    <label for="address">Address</label>
                    <div class="input-with-icon">
                        <i class="fas fa-home input-icon"></i>
                        <textarea id="address" name="address" placeholder="Enter detailed address" required></textarea>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="city">City</label>
                    <div class="input-with-icon">
                        <i class="fas fa-city input-icon"></i>
                        <input type="text" id="city" name="city" placeholder="Enter city" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="pincode">Pincode</label>
                    <div class="input-with-icon">
                        <i class="fas fa-map-pin input-icon"></i>
                        <input type="text" id="pincode" name="pincode" placeholder="Enter pincode" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="capacity">Capacity</label>
                    <div class="input-with-icon">
                        <i class="fas fa-users input-icon"></i>
                        <select id="capacity" name="capacity" required>
                            <option value="" disabled selected>Select capacity</option>
                            <option value="50">50 attendees</option>
                            <option value="100">100 attendees</option>
                            <option value="150">150 attendees</option>
                            <option value="200">200 attendees</option>
                            <option value="250">250 attendees</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="status">Status</label>
                    <div class="input-with-icon">
                        <i class="fas fa-info-circle input-icon"></i>
                        <input type="text" id="status" name="status" value="Upcoming" readonly>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="eventCreatorID">Creator ID</label>
                    <div class="input-with-icon">
                        <i class="fas fa-id-badge input-icon"></i>
                        <input type="number" id="eventCreatorID" name="eventCreatorID" placeholder="Enter your ID" required>
                    </div>
                </div>
                
                <div class="form-group full-width">
                    <label for="description">Description</label>
                    <div class="input-with-icon">
                        <i class="fas fa-align-left input-icon"></i>
                        <textarea id="description" name="description" placeholder="Describe your event" required></textarea>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="sessionStartTime">Start Time</label>
                    <div class="input-with-icon">
                        <i class="fas fa-clock input-icon"></i>
                        <input type="datetime-local" id="sessionStartTime" name="sessionStartTime" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="sessionEndTime">End Time</label>
                    <div class="input-with-icon">
                        <i class="fas fa-clock input-icon"></i>
                        <input type="datetime-local" id="sessionEndTime" name="sessionEndTime" required>
                    </div>
                </div>
                
                <div class="form-group full-width">
                    <label for="eventImage">Event Image URL</label>
                    <div class="input-with-icon">
                        <i class="fas fa-image input-icon"></i>
                        <input type="url" id="eventImage" name="eventImage" placeholder="Enter image URL" required>
                    </div>
                </div>
                
                <div class="btn-container">
                    <button type="button" class="btn-secondary" onclick="window.history.back();">Cancel</button>
                    <button type="submit">Create Event <i class="fas fa-rocket"></i></button>
                </div>
            </form>
        </div>

        <script>
            // Create twinkling stars effect
            document.addEventListener('DOMContentLoaded', function() {
                const starsContainer = document.getElementById('stars');
                const starCount = 100;
                
                for (let i = 0; i < starCount; i++) {
                    const star = document.createElement('div');
                    star.classList.add('star');
                    
                    // Random positions
                    const x = Math.floor(Math.random() * window.innerWidth);
                    const y = Math.floor(Math.random() * window.innerHeight);
                    
                    // Random size
                    const size = Math.random() * 2;
                    
                    // Random animation delay
                    const delay = Math.random() * 5;
                    
                    star.style.left = `${x}px`;
                    star.style.top = `${y}px`;
                    star.style.width = `${size}px`;
                    star.style.height = `${size}px`;
                    star.style.animationDelay = `${delay}s`;
                    
                    starsContainer.appendChild(star);
                }
            });
        </script>
    </body>
    </html> --%>





<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    // Database connection details
    String jdbcURL = "jdbc:oracle:thin:@localhost:1521:xe"; // Update your database details
    String dbUser = "SYSTEM";
    String dbPassword = "BCADB";
    
    // Retrieve the logged-in username from the session
    HttpSession userSession = request.getSession(false);
    String username = (userSession != null) ? (String) userSession.getAttribute("username") : null;
    
    String userId = null; // Variable to store retrieved user_id

    if (username != null) {
        try {
            // Establish connection
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            
            // Query to fetch user_id based on username
            String query = "SELECT user_id FROM Event_users WHERE username = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                userId = rs.getString("user_id");
            }
            
            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Event - Galaxy Edition</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
     <style>
            :root {
                --primary-color: #8B5CF6;
                --secondary-color: #C4B5FD;
                --accent-color: #7C3AED;
                --dark-bg: #0F172A;
                --card-bg: rgba(30, 41, 59, 0.8);
                --border-color: rgba(148, 163, 184, 0.2);
                --text-primary: #F8FAFC;
                --text-secondary: #CBD5E1;
                --text-muted: #94A3B8;
                --success-color: #10B981;
                --input-bg: rgba(15, 23, 42, 0.6);
                --shadow-color: rgba(139, 92, 246, 0.3);
                --border-radius: 12px;
                --box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
                --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            /* Main Elements */
            body {
                background: linear-gradient(135deg, #0F172A, #1E293B, #334155);
                background-attachment: fixed;
                color: var(--text-primary);
                font-family: 'Poppins', sans-serif;
                margin: 0;
                padding: 20px;
                min-height: 100vh;
                position: relative;
                overflow-x: hidden;
            }

            body::before {
                content: '';
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-image: 
                    radial-gradient(circle at 20% 35%, rgba(139, 92, 246, 0.15) 0%, transparent 50%),
                    radial-gradient(circle at 80% 10%, rgba(139, 92, 246, 0.1) 0%, transparent 50%);
                pointer-events: none;
                z-index: -1;
            }

            .stars {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                pointer-events: none;
                z-index: -1;
            }

            .star {
                position: absolute;
                background-color: white;
                border-radius: 50%;
                opacity: 0.6;
                animation: twinkle 5s infinite ease-in-out;
            }

            @keyframes twinkle {
                0%, 100% { opacity: 0.2; }
                50% { opacity: 0.7; }
            }

            /* Container Styling */
            .container {
                max-width: 800px;
                width: 100%;
                margin: 20px auto;
                background: var(--card-bg);
                backdrop-filter: blur(10px);
                border: 1px solid var(--border-color);
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                padding: 40px;
                position: relative;
                overflow: hidden;
                z-index: 1;
            }

            .container::before {
                content: '';
                position: absolute;
                top: -2px;
                left: -2px;
                right: -2px;
                bottom: -2px;
                background: linear-gradient(45deg, var(--primary-color), transparent, var(--primary-color));
                z-index: -1;
                transform: scale(1.05);
                filter: blur(20px);
                opacity: 0.3;
                transition: var(--transition);
                border-radius: inherit;
            }

            .container:hover::before {
                opacity: 0.4;
                animation: border-flow 3s infinite alternate;
            }

            @keyframes border-flow {
                0% { background-position: 0% 50%; }
                100% { background-position: 100% 50%; }
            }

            /* Header Styling */
            h2 {
                font-size: 28px;
                color: var(--text-primary);
                margin-bottom: 30px;
                text-align: center;
                font-weight: 600;
                letter-spacing: 0.5px;
                text-transform: uppercase;
                background: linear-gradient(to right, var(--text-primary), var(--secondary-color));
                -webkit-background-clip: text;
                background-clip: text;
                color: transparent;
            }

            /* Form Styling */
            form {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            .form-group {
                position: relative;
                margin-bottom: 5px;
            }

            .form-group.full-width {
                grid-column: span 2;
            }

            label {
                display: block;
                font-size: 14px;
                margin-bottom: 8px;
                color: var(--secondary-color);
                font-weight: 500;
                transition: var(--transition);
            }

            input, select, textarea {
                width: 100%;
                padding: 12px 15px;
                background: var(--input-bg);
                border: 1px solid var(--border-color);
                border-radius: 8px;
                color: var(--text-primary);
                font-size: 15px;
                transition: var(--transition);
                font-family: inherit;
                box-sizing: border-box;
            }

            input:focus, select:focus, textarea:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 3px var(--shadow-color);
            }

            input::placeholder, textarea::placeholder {
                color: var(--text-muted);
            }

            textarea {
                resize: vertical;
                min-height: 100px;
            }

            /* Icon styling */
            .input-with-icon {
                position: relative;
            }

            .input-icon {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                left: 12px;
                color: var(--secondary-color);
                font-size: 16px;
            }

            .input-with-icon input,
            .input-with-icon select {
                padding-left: 40px;
            }

            /* Button styling */
            .btn-container {
                grid-column: span 2;
                margin-top: 10px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            button {
                background: linear-gradient(45deg, var(--primary-color), var(--accent-color));
                color: white;
                border: none;
                border-radius: 30px;
                padding: 14px 30px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: var(--transition);
                box-shadow: 0 4px 20px rgba(124, 58, 237, 0.3);
                position: relative;
                overflow: hidden;
                z-index: 1;
                font-family: inherit;
            }

            button::before {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transition: all 0.6s;
                z-index: -1;
            }

            button:hover {
                transform: translateY(-3px);
                box-shadow: 0 7px 25px rgba(124, 58, 237, 0.5);
            }

            button:hover::before {
                left: 100%;
            }

            .btn-secondary {
                background: transparent;
                border: 1px solid var(--secondary-color);
                color: var(--secondary-color);
                box-shadow: none;
            }

            .btn-secondary:hover {
                background: rgba(139, 92, 246, 0.1);
                box-shadow: 0 4px 15px rgba(139, 92, 246, 0.15);
            }

            /* Responsive styling */
            @media (max-width: 768px) {
                .container {
                    padding: 25px;
                    width: 90%;
                }

                form {
                    grid-template-columns: 1fr;
                }

                .form-group.full-width {
                    grid-column: span 1;
                }

                .btn-container {
                    grid-column: span 1;
                    flex-direction: column;
                    gap: 15px;
                }

                button {
                    width: 100%;
                }

                h2 {
                    font-size: 24px;
                }
            }

            /* Animation */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .container {
                animation: fadeIn 0.6s ease-out forwards;
            }

            /* Custom select styling */
            select {
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' fill='none' stroke='%23C4B5FD' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 16px;
            }
        </style>
</head>


 <body>
        <!-- Stars background -->
        <div class="stars" id="stars"></div>
        
        <div class="container">
            <h2>Create New Galaxy Event</h2>
            <form action="CreateEventServlet" method="post">
                <div class="form-group">
                    <label for="eventName">Event Name</label>
                    <div class="input-with-icon">
                        <i class="fas fa-calendar-alt input-icon"></i>
                        <input type="text" id="eventName" name="eventName" placeholder="Enter event name" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="location">Location</label>
                    <div class="input-with-icon">
                        <i class="fas fa-map-marker-alt input-icon"></i>
                        <input type="text" id="location" name="location" placeholder="Enter location name" required>
                    </div>
                </div>

                <div class="form-group full-width">
                    <label for="address">Address</label>
                    <div class="input-with-icon">
                        <i class="fas fa-home input-icon"></i>
                        <textarea id="address" name="address" placeholder="Enter detailed address" required></textarea>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="city">City</label>
                    <div class="input-with-icon">
                        <i class="fas fa-city input-icon"></i>
                        <input type="text" id="city" name="city" placeholder="Enter city" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="pincode">Pincode</label>
                    <div class="input-with-icon">
                        <i class="fas fa-map-pin input-icon"></i>
                        <input type="text" id="pincode" name="pincode" placeholder="Enter pincode" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="capacity">Capacity</label>
                    <div class="input-with-icon">
                        <i class="fas fa-users input-icon"></i>
                        <select id="capacity" name="capacity" required>
                            <option value="" disabled selected>Select capacity</option>
                            <option value="50">50 attendees</option>
                            <option value="100">100 attendees</option>
                            <option value="150">150 attendees</option>
                            <option value="200">200 attendees</option>
                            <option value="250">250 attendees</option>
                        </select>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="status">Status</label>
                    <div class="input-with-icon">
                        <i class="fas fa-info-circle input-icon"></i>
                        <input type="text" id="status" name="status" value="Upcoming" readonly>
                    </div>
                </div>
                
                


                 <div class="form-group">
            <label>User ID (Auto-filled from DB)</label>
            <input type="text" name="user_id" value="<%= (userId != null) ? userId : "User not found" %>" readonly>
                </div>
                
                <div class="form-group full-width">
                    <label for="description">Description</label>
                    <div class="input-with-icon">
                        <i class="fas fa-align-left input-icon"></i>
                        <textarea id="description" name="description" placeholder="Describe your event" required></textarea>
                    </div>
                </div>
                
               <div class="form-group">
    <label for="sessionStartDate">Start Date</label>
    <div class="input-with-icon">
        <i class="fas fa-calendar input-icon"></i>
        <input type="date" id="sessionStartDate" name="sessionStartDate" required>
    </div>
</div>

<div class="form-group">
    <label for="sessionEndDate">End Date</label>
    <div class="input-with-icon">
        <i class="fas fa-calendar input-icon"></i>
        <input type="date" id="sessionEndDate" name="sessionEndDate" required>
    </div>
</div>

                
                <div class="form-group full-width">
                    <label for="eventImage">Event Image URL</label>
                    <div class="input-with-icon">
                        <i class="fas fa-image input-icon"></i>
                        <input type="url" id="eventImage" name="eventImage" placeholder="Enter image URL" required>
                    </div>
                </div>
                
                <div class="btn-container">
                    <button type="button" class="btn-secondary" onclick="window.history.back();">Cancel</button>
                    <button type="submit">Create Event <i class="fas fa-rocket"></i></button>
                </div>
            </form>
        </div>

        <script>
            // Create twinkling stars effect
            document.addEventListener('DOMContentLoaded', function() {
                const starsContainer = document.getElementById('stars');
                const starCount = 100;
                
                for (let i = 0; i < starCount; i++) {
                    const star = document.createElement('div');
                    star.classList.add('star');
                    
                    // Random positions
                    const x = Math.floor(Math.random() * window.innerWidth);
                    const y = Math.floor(Math.random() * window.innerHeight);
                    
                    // Random size
                    const size = Math.random() * 2;
                    
                    // Random animation delay
                    const delay = Math.random() * 5;
                    
                    star.style.left = `${x}px`;
                    star.style.top = `${y}px`;
                    star.style.width = `${size}px`;
                    star.style.height = `${size}px`;
                    star.style.animationDelay = `${delay}s`;
                    
                    starsContainer.appendChild(star);
                }
            });
        </script>
    </body>


</html>
