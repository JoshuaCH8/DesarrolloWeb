<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.Usuario"%>
<%@page import="Logica.UsuarioDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
    // Verificar sesión y rol de admin
    Usuario usuarioActual = (Usuario) session.getAttribute("usuario");
    if (usuarioActual == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    if (!"admin".equals(usuarioActual.getRol())) {
        response.sendRedirect("Conexion.jsp?error=Acceso denegado");
        return;
    }
    
    // Obtener lista de usuarios
    UsuarioDAO usuarioDAO = new UsuarioDAO();
    List<Usuario> listaUsuarios = usuarioDAO.obtenerTodos();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <meta name="author" content="Tu Nombre" />
        <meta name="description" content="Sistema de Gestión de Usuarios" />
        <meta name="keywords" content="usuarios, sistema, web, administración" />
        <meta name="copyright" content="Tu Nombre" />
        <title>Gestión de Usuarios</title>
    </head>
    <body>
        <div class="container">
            <!-- INCLUIR NAVBAR -->
            <%@include file="navbar.jsp" %>
            
            <h2>Gestión de Usuarios</h2>
            <p class="subtitle">Administración completa de usuarios del sistema</p>

            <%
                String mensaje = request.getParameter("mensaje");
                String error = request.getParameter("error");
                if (mensaje != null) {
            %>
                <div class="mensaje success" style="text-align: center;">
                    <p><strong>✅ <%= mensaje %></strong></p>
                </div>
            <% } %>
            <% if (error != null) { %>
                <div class="mensaje error" style="text-align: center;">
                    <p><strong>❌ <%= error %></strong></p>
                </div>
            <% } %>

            <!-- Estadísticas -->
            <%
                if (!listaUsuarios.isEmpty()) {
                    int totalUsuarios = listaUsuarios.size();
                    int adminCount = 0, editorCount = 0, visorCount = 0;
                    
                    for (Usuario user : listaUsuarios) {
                        switch(user.getRol()) {
                            case "admin": adminCount++; break;
                            case "editor": editorCount++; break;
                            case "visor": visorCount++; break;
                        }
                    }
            %>
            
            <div class="mensaje" style="text-align: center; margin-bottom: 20px;">
                <p>
                    <strong>Total Usuarios: <%= totalUsuarios%> | 
                        Administradores: <%= adminCount%> | 
                        Editores: <%= editorCount%> | 
                        Visores: <%= visorCount%></strong>
                </p>
            </div>

            <!-- Tabla de usuarios -->
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuario</th>
                        <th>Nombre Completo</th>
                        <th>Email</th>
                        <th>Rol</th>
                        <th>Fecha Creación</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Usuario user : listaUsuarios) { 
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                        String fechaCreacion = user.getFechaCreacion() != null ? 
                            sdf.format(user.getFechaCreacion()) : "N/A";
                    %>
                    <tr id="fila-<%= user.getIdUsuario() %>">
                        <td><%= user.getIdUsuario() %></td>
                        <td><strong><%= user.getUsername() %></strong></td>
                        <td><%= user.getNombreCompleto() != null ? user.getNombreCompleto() : "N/A" %></td>
                        <td><%= user.getEmail() != null ? user.getEmail() : "N/A" %></td>
                        <td>
                            <%
                                String rol = user.getRol();
                                String estiloRol = "";
                                if ("admin".equals(rol)) {
                                    estiloRol = "color: #dc3545; font-weight: bold;";
                                } else if ("editor".equals(rol)) {
                                    estiloRol = "color: #ffc107; font-weight: bold;";
                                } else {
                                    estiloRol = "color: #17a2b8; font-weight: bold;";
                                }
                            %>
                            <span style="<%= estiloRol%>">
                                <%= rol %>
                            </span>
                        </td>
                        <td><%= fechaCreacion %></td>
                        <td>
                            <button onclick="editarUsuario(<%= user.getIdUsuario() %>)" 
                                    class="btn btn-warning" style="margin-right: 5px;">
                                Editar
                            </button>
                            <button onclick="eliminarUsuario(<%= user.getIdUsuario() %>, '<%= user.getUsername() %>')" 
                                    class="btn btn-danger">
                                Eliminar
                            </button>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            
            <% } else { %>
            <!-- Estado sin datos -->
            <div class="mensaje" style="text-align: center;">
                <p><strong>No hay usuarios registrados</strong></p>
                <p>El sistema no tiene usuarios configurados.</p>
                <a href="AgregarUsuario.jsp" class="btn btn-success">Agregar Primer Usuario</a>
            </div>
            <% } %>

            <!-- Botones de acción -->
            <div style="text-align: center; margin-top: 20px;">
                <a href="AgregarUsuario.jsp" class="btn btn-success">Agregar Nuevo Usuario</a>
                <a href="Conexion.jsp" class="btn">Volver al Inicio</a>
            </div>
        </div>

        <script>
        function eliminarUsuario(idUsuario, username) {
            if (confirm('¿Estás seguro de eliminar al usuario "' + username + '"?\n\nEsta acción no se puede deshacer.')) {
                // AJAX para eliminar sin recargar
                const formData = new FormData();
                formData.append('idUsuario', idUsuario);
                
                fetch('SvEliminarUsuario', {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    if (response.ok) {
                        // Eliminar fila de la tabla
                        const fila = document.getElementById('fila-' + idUsuario);
                        if (fila) {
                            fila.remove();
                        }
                        mostrarMensaje('Usuario "' + username + '" eliminado exitosamente', 'success');
                        
                        // Si no quedan usuarios, recargar para mostrar mensaje de "no data"
                        const tbody = document.querySelector('.table tbody');
                        if (tbody && tbody.children.length === 0) {
                            setTimeout(() => location.reload(), 1500);
                        }
                    } else {
                        mostrarMensaje('Error al eliminar usuario', 'error');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    mostrarMensaje('Error de conexión al eliminar usuario', 'error');
                });
            }
        }
        
        function editarUsuario(idUsuario) {
            // Redirigir a página de edición
            window.location.href = 'EditarUsuario.jsp?id=' + idUsuario;
        }
        
        function mostrarMensaje(mensaje, tipo) {
            // Crear mensaje temporal
            const div = document.createElement('div');
            div.className = `mensaje ${tipo}`;
            div.style.textAlign = 'center';
            div.innerHTML = `<p><strong>${mensaje}</strong></p>`;
            
            // Insertar después del subtitle
            const subtitle = document.querySelector('.subtitle');
            subtitle.parentNode.insertBefore(div, subtitle.nextSibling);
            
            // Auto-eliminar después de 4 segundos
            setTimeout(() => {
                if (div.parentNode) {
                    div.parentNode.removeChild(div);
                }
            }, 4000);
        }
        </script>

        <!-- Validadores (opcionales) -->
        <p>
            <a href="https://validator.w3.org/check?uri=referer">
                <img src="https://www.w3.org/Icons/valid-xhtml11-blue" alt="Valid XHTML 1.1" height="31" width="88" />
            </a>
        </p>
        <p>
            <a href="https://jigsaw.w3.org/css-validator/check/referer">
                <img style="border:0;width:88px;height:31px"
                     src="https://jigsaw.w3.org/css-validator/images/vcss-blue"
                     alt="Valid CSS!" />
            </a>
        </p>
    </body>
</html>