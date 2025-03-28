<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Registration - Galaxy Edition</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: url('https://png.pngtree.com/thumb_back/fh260/background/20231030/pngtree-vibrant-christmas-background-abstract-purple-neon-bokeh-with-fantasy-golden-texture-image_13714650.png') no-repeat center center fixed;
            background-size: cover;
            color: white;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        /* Improved Navbar */
        .navbar {
            height: 80px;
            background-color: rgba(17, 17, 17, 0.9);
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            padding: 10px 2rem;
        }
        
        .navbar-brand {
            font-size: 28px;
            font-weight: bold;
            color: #fff;
            transition: color 0.3s ease;
            display: flex;
            align-items: center;
        }
        
        .navbar-brand i {
            margin-right: 10px;
            color: #9d4edd;
        }
        
        .navbar-brand:hover {
            color: #9d4edd;
        }
        
        .navbar .container-fluid {
            display: flex;
            justify-content: space-between;
        }
        
        .navbar-nav {
            margin-left: auto;
        }
        
        .navbar-nav .nav-link {
            font-size: 16px;
            font-weight: 500;
            color: rgba(255, 255, 255, 0.85);
            padding: 10px 15px;
            transition: all 0.3s ease;
            position: relative;
            margin: 0 5px;
        }
        
        .navbar-nav .nav-link:hover {
            color: #9d4edd;
        }
        
        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            width: 100%;
            height: 2px;
            background-color: #9d4edd;
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }
        
        .navbar-nav .nav-link:hover::after {
            transform: scaleX(1);
        }
        
        .navbar-toggler {
            border-color: rgba(255, 255, 255, 0.5);
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        /* Improved Hero Section */
        .hero-section {
            height: 700px;
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                        url('https://static.vecteezy.com/system/resources/thumbnails/027/104/127/small_2x/cheering-crowd-illuminated-by-vibrant-stage-lights-at-concert-photo.jpg') center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            text-shadow: 2px 2px 5px rgba(0,0,0,0.7);
            margin: 0;
            padding: 0;
            position: relative;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(157, 78, 221, 0.3) 0%, rgba(0, 0, 0, 0.6) 70%);
        }
        
        .hero-content {
            position: relative;
            z-index: 2;
            padding: 2rem;
            background-color: rgba(0, 0, 0, 0.4);
            border-radius: 20px;
            max-width: 800px;
            backdrop-filter: blur(5px);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        }
        
        .hero-section h1 {
            font-size: 54px;
            font-weight: bold;
            margin-bottom: 15px;
            color: #fff;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        
        .hero-section p {
            font-size: 24px;
            font-weight: 400;
            margin-bottom: 25px;
            color: rgba(255, 255, 255, 0.9);
        }
        
        .hero-section .btn-primary {
            font-size: 18px;
            font-weight: bold;
            padding: 12px 30px;
            border-radius: 30px;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 4px 15px rgba(90, 24, 154, 0.5);
            transition: all 0.3s ease;
        }
        
        .hero-section .btn-primary:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(90, 24, 154, 0.7);
        }
        
        /* Improved Countdown */
        .countdown-section {
            background-color: rgba(0, 0, 0, 0.7);
            padding: 40px 0;
            margin-top: -50px;
            position: relative;
            z-index: 10;
            box-shadow: 0 -10px 30px rgba(0, 0, 0, 0.3);
        }
        
        #countdown {
            font-size: 2.5rem;
            font-weight: bold;
            background: linear-gradient(135deg, #5a189a, #9d4edd);
            padding: 20px 30px;
            display: inline-block;
            border-radius: 15px;
            box-shadow: 0px 0px 20px rgba(157, 78, 221, 0.5);
            margin-top: 20px;
            letter-spacing: 2px;
        }
        
        /* Improved Event Cards */
        .events-header {
            position: relative;
            padding-bottom: 20px;
            margin-bottom: 40px;
        }
        
        .events-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(to right, #5a189a, #9d4edd);
        }
        
        .card {
            background: rgba(0, 0, 0, 0.8);
            color: white;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.5);
            border-radius: 15px;
            overflow: hidden;
            border: 1px solid rgba(157, 78, 221, 0.3);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
        }
        
        .card img {
            height: 220px;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0px 15px 30px rgba(157, 78, 221, 0.4);
        }
        
        .card:hover img {
            transform: scale(1.1);
        }
        
        .card-body {
            padding: 1.5rem;
        }
        
        .card-title {
            font-size: 1.4rem;
            font-weight: bold;
            margin-bottom: 15px;
            color: #fff;
        }
        
        .badge {
            font-size: 0.9rem;
            padding: 8px 15px;
            margin-right: -20px;
            margin-top: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #5a189a, #9d4edd);
            border: none;
            border-radius: 30px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: linear-gradient(135deg, #9d4edd, #5a189a);
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(90, 24, 154, 0.4);
        }
        
        /* Improved About Section */
        #about {
            position: relative;
            padding: 80px 0;
            margin-top: 80px;
        }
        
        #about .container {
            background: rgba(18, 18, 18, 0.7);
            border-radius: 20px;
            padding: 40px;
            backdrop-filter: blur(10px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(157, 78, 221, 0.3);
        }
        
        #about h2 {
            position: relative;
            display: inline-block;
            margin-bottom: 30px;
        }
        
        #about h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(to right, #5a189a, #9d4edd);
        }
        
        .stats-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            margin-top: 40px;
        }
        
        .stat-item {
            text-align: center;
            padding: 20px;
            background: rgba(0, 0, 0, 0.5);
            border-radius: 10px;
            min-width: 150px;
            backdrop-filter: blur(5px);
            border: 1px solid rgba(157, 78, 221, 0.3);
            transition: transform 0.3s ease;
        }
        
        .stat-item:hover {
            transform: translateY(-10px);
        }
        
        .stat-item h3 {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #f5c7ff, #9d4edd);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        /* Contact & Complaints Sections */
        #contact, #complaints {
            background: rgba(0, 0, 0, 0.7);
            border-radius: 15px;
            padding: 40px;
            margin: 60px auto;
            max-width: 900px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(157, 78, 221, 0.3);
        }
        
        #contact h2, #complaints h2 {
            position: relative;
            display: inline-block;
            margin-bottom: 25px;
            color: #fff;
        }
        
        #contact h2::after, #complaints h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(to right, #5a189a, #9d4edd);
        }
        
        /* Footer */
        footer {
            background-color: rgba(0, 0, 0, 0.9);
            color: white;
            padding: 40px 0 20px;
            text-align: center;
        }
        
        .social-icons {
            margin: 20px 0;
        }
        
        .social-icons a {
            color: white;
            font-size: 24px;
            margin: 0 10px;
            transition: all 0.3s ease;
        }
        
        .social-icons a:hover {
            color: #9d4edd;
            transform: translateY(-5px);
        }
        
        /* Dropdown styling */
        .dropdown-menu {
            background-color: rgba(0, 0, 0, 0.9);
            border: 1px solid rgba(157, 78, 221, 0.3);
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            padding: 10px 0;
        }
        
        .dropdown-item {
            color: white;
            padding: 10px 20px;
            transition: all 0.3s ease;
        }
        
        .dropdown-item:hover {
            background: linear-gradient(135deg, rgba(90, 24, 154, 0.5), rgba(157, 78, 221, 0.5));
            color: white;
        }
    </style>
</head>
<body>

<!-- Improved Navbar with Logo on Left and Navigation on Right -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">
            <i class="fas fa-galaxy"></i> Galactic EventHub
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="#home">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#events">Events</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#about">About</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#contact">Contact</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp">Login</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="register.jsp">Register</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        More Options
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <li><a class="dropdown-item" href="#complaints">Submit Complaint</a></li>
                        <li><a class="dropdown-item" href="#">Support</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">FAQ</a></li>
                        <li><a class="dropdown-item" href="#">Terms & Conditions</a></li>
                        <li><a class="dropdown-item" href="#">Privacy Policy</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section id="home" class="hero-section">
    <div class="hero-content">
        <h1>Welcome to the Galactic EventHub</h1>
        <p>Join us in an event beyond the stars.</p>
        <a href="#events" class="btn btn-primary">Explore Events</a>
    </div>
</section>

<!-- Countdown Section -->
<div class="countdown-section text-center">
    <h2>Countdown to the Next Big Event</h2>
    <div id="countdown"></div>
</div>

<!-- Events Section -->
<section id="events" class="container my-5">
    <div class="text-center events-header">
        <h2 class="display-4 text-white">Upcoming Events</h2>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card h-100">
                <div class="position-relative overflow-hidden">
                    <img src="https://cdn.prod.website-files.com/646caab5700fe0d1824a61b9/65170c1e01c86d489de784dd_hackathon.png" class="card-img-top" alt="Event 1">
                    <span class="badge bg-success position-absolute top-0 end-0 m-3">New</span>
                </div>
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Intergalactic Hackathon</h5>
                    <p class="card-text mb-4">Solve cosmic coding challenges with developers from across the galaxy. Win prizes and recognition.</p>
                    <div class="mt-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <small><i class="far fa-calendar-alt me-2"></i>Apr 15, 2025</small>
                            <small><i class="fas fa-map-marker-alt me-2"></i>Virtual</small>
                        </div>
                        <a href="#" class="btn btn-primary w-100">Register Now</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100">
                <div class="position-relative overflow-hidden">
                    <img src="https://boombarstick.com/wp-content/uploads/2020/11/67658690_10156869451539177_2868809369410076672_o-2.jpg" class="card-img-top" alt="Event 2">
                    <span class="badge bg-warning text-dark position-absolute top-0 end-0 m-3">Popular</span>
                </div>
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Nebula Music Fest</h5>
                    <p class="card-text mb-4">Experience live cosmic beats from artists across dimensions. A night of stellar performances.</p>
                    <div class="mt-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <small><i class="far fa-calendar-alt me-2"></i>May 20, 2025</small>
                            <small><i class="fas fa-map-marker-alt me-2"></i>Cosmic Arena</small>
                        </div>
                        <a href="#" class="btn btn-primary w-100">Register Now</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card h-100">
                <div class="position-relative overflow-hidden">
                    <img src="https://www.fodors.com/wp-content/uploads/2018/11/HERO_EuropeanXmasMarketTreats_Hero_shutterstock_190888703_1.jpg" class="card-img-top" alt="Event 3">
                    <span class="badge bg-danger position-absolute top-0 end-0 m-3">Limited</span>
                </div>
                <div class="card-body d-flex flex-column">
                    <h5 class="card-title">Starry Food Carnival</h5>
                    <p class="card-text mb-4">Taste out-of-this-world flavors from across the universe. A culinary journey like no other.</p>
                    <div class="mt-auto">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <small><i class="far fa-calendar-alt me-2"></i>Jun 8, 2025</small>
                            <small><i class="fas fa-map-marker-alt me-2"></i>Lunar Gardens</small>
                        </div>
                        <a href="#" class="btn btn-primary w-100">Register Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- About Section -->
<section id="about" class="position-relative text-white py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-10 text-center">
                <h2 class="display-4 fw-bold mb-4">About EventHub</h2>
                
                <p class="lead mb-4" style="font-size: 1.25rem; font-weight: 400; line-height: 1.8;">
                    Welcome to <strong>EventHub</strong>, your all-in-one destination for exploring events that match your interests.
                    From cutting-edge tech fests to cultural extravaganzas, find, register, and experience it all with ease.
                </p>

                <p class="mb-4" style="font-size: 1.1rem; line-height: 1.7;">
                    Our intelligent platform curates recommendations tailored to your preferences, ensuring you never miss an event you'll love.
                    Join a growing community of learners, creators, and enthusiasts who come together to celebrate innovation, culture, and fun.
                </p>

                <p class="fw-bold text-light" style="font-size: 1.3rem; letter-spacing: 1px;">
                    Discover. Register. Experience. Together.
                </p>

                <!-- Dynamic Counter / Statistic Section -->
                <div class="stats-container">
                    <div class="stat-item">
                        <h3>500+</h3>
                        <p class="mb-0">Events Hosted</p>
                    </div>
                    <div class="stat-item">
                        <h3>10K+</h3>
                        <p class="mb-0">Attendees</p>
                    </div>
                    <div class="stat-item">
                        <h3>50+</h3>
                        <p class="mb-0">Cities Covered</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Contact Us Section -->
<section id="contact" class="text-center">
    <h2>Contact Us</h2>
    <p class="mb-4">We'd love to hear from you. Reach out to us with any questions or inquiries.</p>
    
    <div class="row justify-content-center mt-4">
        <div class="col-md-4">
            <div class="mb-4">
                <i class="fas fa-envelope fa-2x mb-3" style="color: #9d4edd;"></i>
                <h5>Email Us</h5>
                <p>support@eventhub.com</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="mb-4">
                <i class="fas fa-phone fa-2x mb-3" style="color: #9d4edd;"></i>
                <h5>Call Us</h5>
                <p>+91-9876543210</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="mb-4">
                <i class="fas fa-map-marker-alt fa-2x mb-3" style="color: #9d4edd;"></i>
                <h5>Find Us</h5>
                <p>123 Galaxy Street, Cosmos City</p>
            </div>
        </div>
    </div>
</section>

<!-- Complaints Section -->
<section id="complaints" class="text-center">
    <h2>Complaints</h2>
    <p class="mb-4">If you have any concerns, feel free to submit your feedback. We take every complaint seriously.</p>
    
    <a href="#" class="btn btn-primary">Submit Your Complaint</a>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <a class="navbar-brand mb-4 d-inline-block" href="#">
                    <i class="fas fa-galaxy"></i> Galactic EventHub
                </a>
                
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                </div>
                
                <p class="mt-4">&copy; 2025 Galactic EventHub. All rights reserved.</p>
            </div>
        </div>
    </div>
</footer>

<script>
    // Countdown Script
    const countdownDate = new Date("2025-04-01T00:00:00").getTime();
    const interval = setInterval(() => {
        const now = new Date().getTime();
        const distance = countdownDate - now;
        if (distance < 0) {
            clearInterval(interval);
            document.getElementById("countdown").innerHTML = "Event Started!";
        } else {
            const days = Math.floor(distance / (1000 * 60 * 60 * 24));
            const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
            document.getElementById("countdown").innerHTML = `${days}d ${hours}h ${minutes}m ${seconds}s`;
        }
    }, 1000);
    
    // Smooth scrolling for navigation
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            if(targetId === '#') return;
            
            const targetElement = document.querySelector(targetId);
            if(targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 90,
                    behavior: 'smooth'
                });
            }
        });
    });
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>