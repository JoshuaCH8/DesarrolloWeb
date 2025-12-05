<%-- navbar.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.Usuario"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>

<div class="simple-navbar">
    <div class="user-simple">
        <span class="user-text">
            <%= usuario.getNombreCompleto() != null ? usuario.getNombreCompleto() : usuario.getUsername() %>
            <span class="role-simple">(<%= usuario.getRol() %>)</span>
        </span>
    </div>
    
    <div class="logout-simple">
        <form action="SvLogin" method="GET">
            <button type="submit" class="btn-logout-simple">Salir</button>
        </form>
    </div>
</div>

<style>
.simple-navbar {
    background: #f8f9fa;
    border: 1px solid #dee2e6;
    padding: 10px 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    border-radius: 4px;
}

.user-text {
    font-size: 14px;
    color: #495057;
}

.role-simple {
    color: #6c757d;
    font-size: 12px;
}

.btn-logout-simple {
    background: #dc3545;
    color: white;
    border: none;
    padding: 5px 12px;
    border-radius: 3px;
    cursor: pointer;
    font-size: 12px;
}

.btn-logout-simple:hover {
    background: #c82333;
}
</style>