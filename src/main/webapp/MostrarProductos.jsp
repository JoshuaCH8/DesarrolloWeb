<%-- 
    Document   : MostrarProductos
    Created on : 2 oct. 2025, 14:15:59
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
<%@page import = "java.util.List" %>
<%@page import = "java.util.ArrayList" %>
<%@ page import="Logica.Producto" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Mostrar Productos</title>
    </head>
    <body>
        <h2>Lista de Productos.</h2>
        
        <%
            List<Producto> lista_productos = (List<Producto>)request.getAttribute("lista_productos");
            if (lista_productos != null && !lista_productos.isEmpty()) {            
        %>
            <table border="1" style="width: 100%;">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Cantidad</th>
                    <th>Código Barras</th>
                    <th>Categoría ID</th>
                </tr>
                <%
                    for (Producto producto : lista_productos) {
                %>
                    <tr>
                        <td><%= producto.getIdProducto() %></td>
                        <td><%= producto.getNombreProducto() %></td>
                        <td>$<%= producto.getPrecioProducto() %></td>
                        <td><%= producto.getCantidadProducto() %></td>
                        <td><%= producto.getCodigoBarras() %></td>
                        <td><%= producto.getCategoriaId() %></td>
                    </tr>
                <% } %>
            </table>
        <%
            } else {
        %>
            <p>No hay productos disponibles</p>
        <% } %>
        
    <!-- Ruta Absoluta al inicio -->
    <a href="/prueba/Conexion.jsp">Regresar al Inicio</a>        
    </body>
</html>
