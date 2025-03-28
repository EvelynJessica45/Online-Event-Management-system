# 🗓️ Online Event Management System

## 📌 Overview
The **Online Event Management System** is a web-based application designed to simplify event registration and management. Built using **Java Servlets, JSP, and SQL**, it allows users to register for events, view details, and manage their bookings efficiently.

## 🚀 Features
- 🎟️ **User Registration & Authentication** (Session Management)
- 📅 **Event Creation & Management** (For Admins)
- 🔍 **Browse & Register for Events**
- 📝 **Dynamic Event Listings (JSP)**
- 📊 **Booking Summary & History**
- 🟢 **Database Integration (MySQL)**
- 🔒 **Secure Authentication with Servlets & Sessions**

 ### Screenshots

![Event Registration Page](https://github.com/EvelynJessica45/Online-Event-Management-system/raw/f47a5aa3b09500ec9237268d09fe260a40b78793/localhost_6060_event_registration_(high%20res)%20(1).png)

### Event Registration Page
![Event Registration Page](https://github.com/EvelynJessica45/Online-Event-Management-system/raw/953c88f8cee4e8114955d2e4dbc104d1bab8a74b/localhost_6060_event_registration_(high%20res).png)

### Event Registration Page (Alternative View)
![Event Registration Page 2](https://github.com/EvelynJessica45/Online-Event-Management-system/raw/953c88f8cee4e8114955d2e4dbc104d1bab8a74b/localhost_6060_event_registration_(high%20res)%20(2).png)

### Create Event Page
![Create Event Page](https://github.com/EvelynJessica45/Online-Event-Management-system/raw/953c88f8cee4e8114955d2e4dbc104d1bab8a74b/localhost_6060_event_registration_createEvent.jsp(high%20res).png)

### Login Page
![Login Page](https://github.com/EvelynJessica45/Online-Event-Management-system/raw/953c88f8cee4e8114955d2e4dbc104d1bab8a74b/localhost_6060_event_registration_login.jsp(high%20res).png)

### User Dashboard
![User Dashboard](https://github.com/EvelynJessica45/Online-Event-Management-system/raw/953c88f8cee4e8114955d2e4dbc104d1bab8a74b/localhost_6060_event_registration_userDashboard.jsp(high%20res).png)



## 🛠️ Tech Stack
- **Backend:** Java Servlets, JSP
- **Frontend:** HTML, CSS, Bootstrap
- **Database:** MySQL
- **Server:** Apache Tomcat

## 👤 Project Structure
```
/event_management_system
│── src/main/webapp
│   ├── index.jsp
│   ├── login.jsp
│   ├── register.jsp
│   ├── events.jsp
│   ├── booking.jsp
│── src/main/java/com/eventmanagement
│   ├── controllers/
│   ├── models/
│   ├── dao/
│── database/
│   ├── event_management.sql
```

## 🎯 Setup Instructions
1. Clone the repository:
   ```sh
   git clone https://github.com/EvelynJessica45/Online-Event-Management-system.git
   ```
2. Import the project into **Eclipse/IntelliJ**.
3. Configure **Apache Tomcat** and deploy the project.
4. Set up the database:
   - Create a database in MySQL:  
     ```sql
     CREATE DATABASE event_management;
     ```
   - Import the provided `event_management.sql` file.
5. Update `web.xml` with database credentials.
6. Run the project and access it via:
   ```
   http://localhost:8080/event_management
   ```

## 🖼️ Screenshots
![Home Page](https://github.com/EvelynJessica45/Online-Event-Management-system/blob/main/screenshots/home.png)
![Event Registration](https://github.com/EvelynJessica45/Online-Event-Management-system/blob/main/screenshots/register.png)
![Booking Summary](https://github.com/EvelynJessica45/Online-Event-Management-system/blob/main/screenshots/summary.png)

## 👩‍💻 Contributor
**Evelyn Jessica**  
[GitHub](https://github.com/EvelynJessica45) | [LinkedIn](https://www.linkedin.com/in/evelyn-jessica-9a066a231/)

---

🌟 **Feel free to contribute!** If you find any bugs or have feature suggestions, open an issue or pull request. 🚀

