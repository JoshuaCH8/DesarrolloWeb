<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <link rel="stylesheet" type="text/css" href="css/estilos.css" />
    <title>Iniciar Sesión - Sistema de Gestión</title>
    <style>
        .login-container {
            max-width: 400px;
            margin: 100px auto;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .btn-login {
            width: 100%;
            padding: 12px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-login:hover {
            background: #45a049;
        }
        .error {
            color: #dc3545;
            background: #f8d7da;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2 style="text-align: center; margin-bottom: 30px;">Iniciar Sesión</h2>
        
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error">
                <%= error %>
            </div>
        <% } %>
        
        <form action="SvLogin" method="POST">
            <div class="form-group">
                <label for="username" class="form-label">Usuario:</label>
                <input type="text" id="username" name="username" class="form-input" required />
            </div>
            
            <div class="form-group">
                <label for="password" class="form-label">Contraseña:</label>
                <input type="password" id="password" name="password" class="form-input" required />
            </div>
            
            <button type="submit" class="btn-login">Ingresar</button>
        </form>
        
        <div style="text-align: center; margin-top: 20px;">
            <p><strong>Credenciales de prueba:</strong></p>
            <p>Admin: admin / admin123</p>
            <p>Editor: editor / editor123</p>
        </div>
    </div>
</body>
</html>