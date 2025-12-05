<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <title>Agregar Usuario</title>
        <style type="text/css">
            .validation-message {
                margin-top: 5px;
                padding: 8px;
                border-radius: 4px;
                font-size: 14px;
            }
            .success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }
            .error {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .loading {
                background: #d1ecf1;
                color: #0c5460;
                border: 1px solid #bee5eb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <!-- INCLUIR NAVBAR -->
            <%@include file="navbar.jsp" %>
            <h2>Agregar Nuevo Usuario</h2>
            <p class="subtitle">Complete el formulario para registrar un nuevo usuario</p>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% }%>

            <form action="SvAgregarUsuario" method="post" class="form-simple">
                <div class="form-group">
                    <label for="username" class="form-label">Nombre de Usuario:</label>
                    <input type="text" name="username" id="username" class="form-input" 
                           required="required" />
                    <div id="mensajeUsuario" class="validation-message">
                        <!-- Aquí aparecerá el mensaje AJAX -->
                    </div>
                </div>

                <div class="form-group">
                    <label for="password" class="form-label">Contraseña:</label>
                    <input type="password" name="password" id="password" class="form-input" required="required" />
                </div>

                <div class="form-group">
                    <label for="nombre_completo" class="form-label">Nombre Completo:</label>
                    <input type="text" name="nombre_completo" id="nombre_completo" class="form-input" required="required" />
                </div>

                <div class="form-group">
                    <label for="email" class="form-label">Email:</label>
                    <input type="text" name="email" id="email" class="form-input" />
                </div>

                <div class="form-group">
                    <label for="rol" class="form-label">Rol:</label>
                    <select name="rol" id="rol" class="form-input" required="required">
                        <option value="">Seleccione un rol</option>
                        <option value="admin">Administrador</option>
                        <option value="editor">Editor</option>
                        <option value="visor">Visor</option>
                    </select>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-success" id="submitBtn">Agregar Usuario</button>
                    <a href="Conexion.jsp" class="btn">Cancelar</a>
                </div>
            </form>
        </div>

        <script type="text/javascript">
            // Función de validación AJAX
            function validarUsuario() {
                var username = document.getElementById('username').value;
                var mensajeDiv = document.getElementById('mensajeUsuario');

                if (username.length < 3) {
                    mensajeDiv.innerHTML = '';
                    return;
                }

                // Mostrar loading
                mensajeDiv.innerHTML = '<span class="loading">Verificando disponibilidad...</span>';

                // AJAX
                var xhr = new XMLHttpRequest();
                xhr.open('GET', 'SvValidarUsuarioAjax?username=' + encodeURIComponent(username), true);

                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        try {
                            var resultado = JSON.parse(xhr.responseText);
                            mensajeDiv.innerHTML = '<span class="' + resultado.clase + '">' + resultado.mensaje + '</span>';

                            // deshabilitar botón si usuario no es válido
                            if (!resultado.valido) {
                                document.getElementById('submitBtn').disabled = true;
                            } else {
                                document.getElementById('submitBtn').disabled = false;
                            }
                        } catch (e) {
                            mensajeDiv.innerHTML = '<span class="error">Error en validación</span>';
                        }
                    }
                };

                xhr.send();
            }

            // Configurar eventos cuando la página carga
            document.addEventListener('DOMContentLoaded', function() {
                var usernameField = document.getElementById('username');
                
                // Evento para validar mientras escribe
                usernameField.addEventListener('input', validarUsuario);
                
                // Evento para limpiar mensaje cuando pierde foco
                usernameField.addEventListener('blur', function () {
                    if (this.value.length < 3) {
                        document.getElementById('mensajeUsuario').innerHTML = '';
                    }
                });
            });
        </script>
    </body>
</html>