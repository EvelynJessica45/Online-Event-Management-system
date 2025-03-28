<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
  <style>
          body {
            background: url('https://png.pngtree.com/thumb_back/fh260/background/20231030/pngtree-vibrant-christmas-background-abstract-purple-neon-bokeh-with-fantasy-golden-texture-image_13714650.png') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            margin: 0;
            padding-top: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: Arial, sans-serif;
        }
        .navbar {
    height: 80px;  /* Increase navbar height */
    background-color: #111;  /* Dark background for contrast */
    box-shadow: 0 2px 10px rgba(0,0,0,0.2); /* Subtle shadow */
    padding: 10px 0; /* Add padding for better spacing */
}

.navbar-brand {
    font-size: 28px;
    font-weight: bold;
    color: white;
    transition: color 0.3s ease;
}

.navbar-brand:hover {
 /* Lavender background */
    color: #9d4edd /* Darker lavender (relative color) */
}


.navbar-nav .nav-link {
    font-size: 18px;
    font-weight: 500;
    color: white;
    padding: 10px 15px;
    transition: all 0.3s ease;
    position: relative; /* Needed for underline effect */
}

/* Hover Effect */
.navbar-nav .nav-link:hover {
    background-color: lavender; /* Lavender background */
    color: #4b0082; /* Darker lavender (relative color) */
}

/* Underline effect on hover */
.navbar-nav .nav-link::after {
    content: '';
    position: absolute;
    left: 0;
    bottom: 2px;
    width: 100%;
    height: 2px;
    background-color: #4b0082; /* Relative lavender color */
    transform: scaleX(0);
    transition: transform 0.3s ease;
}

.navbar-nav .nav-link:hover::after {
    transform: scaleX(1); /* Show underline */
}

/* Optional: Style the toggler for better visibility */
.navbar-toggler {
    border-color: white;
}

.navbar-toggler-icon {
    background-color: white;
}

 .form-box {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(70px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 30px;
            border-radius: 15px;
            color: white;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
        }

        h2 {
            margin-bottom: 20px;
            font-weight: bold;
        }

        label {
            font-weight: bold;
        }

  .form-control {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.5);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .form-check-label {
            font-weight: bold;
        }

        .btn-primary {
            background: #4c90ff;
            border: none;
        }

        .btn-primary:hover {
            background: #1c6eff;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand"  href="#">Galactic EventHub</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="login.jsp">Login</a></li>
                <li class="nav-item"><a class="nav-link" href="register.jsp">Register</a></li>

            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="form-box">
                <h2 class="text-center">Register</h2>

                <!-- Role toggle switch -->
                <div class="form-check form-switch mb-3">
                    <input class="form-check-input" type="checkbox" id="roleToggle">
                    <label class="form-check-label" for="roleToggle" id="roleLabel">Register as: User</label>
                </div>

                <form action="RegisterServlet" method="post">
                    <input type="hidden" name="role" id="roleInput" value="user">

                    <!-- Common fields for all -->
                    <div class="mb-3">
                        <label>Username</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>

                    <div class="mb-3">
                        <label>Name</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>

                    <div class="mb-3">
                        <label>Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>

                    <div class="mb-3">
                        <label>Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>

                    <div class="mb-3">
                        <label>Confirm Password</label>
                        <input type="password" class="form-control" name="confirmPassword" required>
                    </div>


                    <!-- Extra space for event creator if required in the future -->

                    <button type="submit" class="btn btn-primary w-100">Register</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    const roleToggle = document.getElementById('roleToggle');
    const roleLabel = document.getElementById('roleLabel');
    const roleInput = document.getElementById('roleInput');

    roleToggle.addEventListener('change', () => {
        if (roleToggle.checked) {
            roleLabel.textContent = 'Register as: Event Creator';
            roleInput.value = 'event_creator';
        } else {
            roleLabel.textContent = 'Register as: User';
            roleInput.value = 'user';
        }
    });
</script>

</body>
</html>
