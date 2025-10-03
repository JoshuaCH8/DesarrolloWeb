<%-- 
    Document   : AgregarCategoria
    Created on : 2 oct. 2025, 20:11:40
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />    
        <title>Agregar Categoria</title>
    </head>
    <body>
        <h2>Agregar Nueva Categoria</h2>
        
        <%
            String mensaje = (String) request.getAttribute("mensaje");
            if (mensaje != null) {
        %>
            <div style="color: <%= mensaje.contains("✅") ? "green" : "red" %>; margin: 10px 0;">
                <%= mensaje %>
            </div>
        <% } %>

        <form action="SvAgregarCategoria" method="POST">
            <label for="nombre_categoria">Nombre de la Categoria:</label>
            <input type="text" name="nombre_categoria" id="nombre_categoria" required/>
            <br />  
            
            <label for="descripcion">Descripcion:</label>
            <input type="text" name="descripcion" id="descripcion" required/>
            <br />            
            
            <button type="submit">Agregar Categoria</button>
        </form>
        
        <br />
        
    </body>
</html>
