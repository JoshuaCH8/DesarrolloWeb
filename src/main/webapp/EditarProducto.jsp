<%-- 
    Document   : EditarProducto
    Created on : 23 sep. 2025, 19:10:02
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.ConexionDB"%>
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
        <title>Modificar Producto</title>
    </head>
    <body>
        <h2>Lista de productos</h2>
    
        <!-- Mostrar mensajes -->
        <%
            String mensaje = (String) request.getAttribute("mensaje");
            if (mensaje != null) {
        %>
            <div style="color: blue; margin: 10px 0;">
                <%= mensaje %>
            </div>
        <% } %>
    
        <%
            List<Producto> lista_productos = (List<Producto>) request.getAttribute("lista_productos");
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
    
        <h3>Modificar Producto</h3>
        <form action="SvEditarProducto" method="POST">
            <!-- Campo ID (OBLIGATORIO) -->
            <label for="id_producto">ID del producto a modificar:</label>
            <input type="number" name="id_producto" id="id_producto" required/>
            <br /><br />
        
            <!-- Campos OPCIONALES -->
            <label for="nuevo_nombre_producto">Nuevo nombre (dejar vacío para no cambiar):</label>
            <input type="text" name="nuevo_nombre_producto" id="nuevo_nombre_producto" placeholder="Ej: Coca Cola 2L"/>
            <br />
        
            <label for="nuevo_precio_producto">Nuevo precio (dejar 0 para no cambiar):</label>
            <input type="number" step="0.01" name="nuevo_precio_producto" id="nuevo_precio_producto" value="0"/>
            <br />
        
            <label for="nueva_cantidad_producto">Nueva cantidad (dejar 0 para no cambiar):</label>
            <input type="number" name="nueva_cantidad_producto" id="nueva_cantidad_producto" value="0"/>
            <br />
        
            <label for="nueva_categoria_id">Nueva categoría ID (dejar 0 para no cambiar):</label>
            <input type="number" name="nueva_categoria_id" id="nueva_categoria_id" value="0"/>
            <br />
        
            <label for="nueva_descripcion">Nueva descripción (dejar vacío para no cambiar):</label>
            <textarea name="nueva_descripcion" id="nueva_descripcion" placeholder="Ej: Refresco de cola"></textarea>
            <br />
        
            <button type="submit">Modificar Producto</button>
        </form>
        
    <!-- Ruta Absoluta al inicio -->
    <a href="/prueba/Conexion.jsp">Regresar al Inicio</a>
    </body>
</html>
