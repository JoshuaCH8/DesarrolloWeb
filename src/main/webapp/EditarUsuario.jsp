<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.Usuario"%>
<%@page import="Logica.UsuarioDAO"%>
<%
    // Verificar sesión y rol
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuario");
    if (usuarioSesion == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    if (!"admin".equals(usuarioSesion.getRol())) {
        response.sendRedirect("Conexion.jsp?error=Acceso denegado");
        return;
    }
    
    // Obtener usuario a editar
    String idParam = request.getParameter("id");
    Usuario usuarioEditar = null;
    
    if (idParam != null && !idParam.isEmpty()) {
        try {
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            usuarioEditar = usuarioDAO.obtenerPorId(Integer.parseInt(idParam));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    if (usuarioEditar == null) {
        response.sendRedirect("ListarUsuarios.jsp?error=Usuario no encontrado");
        return;
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <meta name="author" content="Tu Nombre" />
        <meta name="description" content="Edición de Usuario" />
        <meta name="keywords" content="usuario, editar, sistema" />
        <meta name="copyright" content="Tu Nombre" />
        <title>Editar Usuario</title>
    </head>
    <body>
        <div class="container">
            <%@include file="navbar.jsp" %>
            
            <h2>Editar Usuario</h2>
            <p class="subtitle">Modificar información del usuario del sistema</p>

            <form action="SvEditarUsuario" method="POST" class="form-simple">
                <input type="hidden" name="idUsuario" value="<%= usuarioEditar.getIdUsuario() %>">
                
                <div class="form-group">
                    <label for="username" class="form-label">Nombre de Usuario:</label>
                    <input type="text" name="username" id="username" class="form-input" 
                           value="<%= usuarioEditar.getUsername() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="nombreCompleto" class="form-label">Nombre Completo:</label>
                    <input type="text" name="nombreCompleto" id="nombreCompleto" class="form-input" 
                           value="<%= usuarioEditar.getNombreCompleto() != null ? usuarioEditar.getNombreCompleto() : "" %>" required>
                </div>
                
                <div class="form-group">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" name="email" id="email" class="form-input" 
                           value="<%= usuarioEditar.getEmail() != null ? usuarioEditar.getEmail() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="rol" class="form-label">Rol:</label>
                    <select name="rol" id="rol" class="form-input" required>
                        <option value="admin" <%= "admin".equals(usuarioEditar.getRol()) ? "selected" : "" %>>Administrador</option>
                        <option value="editor" <%= "editor".equals(usuarioEditar.getRol()) ? "selected" : "" %>>Editor</option>
                        <option value="visor" <%= "visor".equals(usuarioEditar.getRol()) ? "selected" : "" %>>Visor</option>
                    </select>
                </div>
                
                <div class="mensaje" style="text-align: center; background: #fff3cd; color: #856404; border-color: #ffeaa7;">
                    <p><strong>Nota:</strong> La contraseña no se puede editar por seguridad. El usuario debe usar su contraseña actual.</p>
                </div>
                
                <div class="form-actions" style="text-align: center; margin-top: 20px;">
                    <button type="submit" class="btn btn-success">Guardar Cambios</button>
                    <a href="ListarUsuarios.jsp" class="btn">Cancelar</a>
                </div>
            </form>
        </div>

        <!-- Validadores -->
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