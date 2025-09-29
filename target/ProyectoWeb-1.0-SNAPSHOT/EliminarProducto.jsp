<%-- 
    Document   : EliminarProducto
    Created on : 23 sep. 2025, 19:10:18
    Author     : sabri
--%>

<%@page import="Logica.ConexionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
<%@page import = "java.util.List" %>
<%@page import = "java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Eliminar Prodcuto</title>
    </head>
    <body>
        
        <%
            ArrayList<String> productos_a_listar = (ArrayList<String>) request.getAttribute("lista_productos");
            if(productos_a_listar != null && !productos_a_listar.isEmpty()) {
        %>
        
        <h2>Lista de Productos</h2>
        <ul>
            <%
                for(String producto: productos_a_listar){
            %>
            
            <li>
                <%= producto%>
            </li>
            
            <% } %>
        </ul>
        
        <% } %>
        
        <br />
        <h3>Eliminar Producto</h3>
        <form action="SvEliminarProducto" method="POST">
            <label for="id_producto">ID del producto a eliminar:</label>
            <input type="number" name="id_producto" id="id_producto" required />
            <br />
            <br />
            <button type="submit">Elminar</button>
        </form>
    </body>
</html>
