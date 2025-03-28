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

