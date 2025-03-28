<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Galactic EventHub</title>
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
            height: 80px;
            background-color: #111;
            box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            padding: 10px 0;
        }
        .navbar-brand {
            font-size: 28px;
            font-weight: bold;
            color: white;
            transition: color 0.3s ease;
        }
        .navbar-brand:hover {
            color: #9d4edd;
        }
        .navbar-nav .nav-link {
            font-size: 18px;
            font-weight: 500;
            color: white;
            padding: 10px 15px;
            transition: all 0.3s ease;
        }
        .navbar-nav .nav-link:hover {
            background-color: lavender;
            color: #4b0082;
        }
        .form-box {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(70px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 30px;
            border-radius: 15px;
            color: white;
             font-weight: bold;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.5);
        }
        .form-control {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.5);
        }
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }
        .btn-primary {
            background: #4c90ff;
            border: none;
        }
        .btn-primary:hover {
            background: #1c6eff;
        }
        h2{
            font-weight: bold;

        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Galactic EventHub</a>
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
        <div class="col-md-5">
            <div class="form-box">
                <h2 class="text-center">Login</h2>

                <!-- Role toggle switch -->
                <div class="form-check form-switch mb-3">
                    <input class="form-check-input" type="checkbox" id="roleToggle">
                    <label class="form-check-label" for="roleToggle" id="roleLabel">Login as: User</label>
                </div>

                <form action="login" method="post">
                    <input type="hidden" name="role" id="roleInput" value="user">

                    <div class="mb-3">
                        <label>Username</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>

                    <div class="mb-3">
                        <label>Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Login</button>
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
            roleLabel.textContent = 'Login as: Event Creator';
            roleInput.value = 'event_creator';
        } else {
            roleLabel.textContent = 'Login as: User';
            roleInput.value = 'user';
        }
    });
</script>

</body>
</html>
