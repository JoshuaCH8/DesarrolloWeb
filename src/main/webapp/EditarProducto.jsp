<%-- 
    Document   : EditarProducto
    Created on : 23 sep. 2025, 19:10:02
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>Modificar Producto</title>
    </head>
    <body>
        <h2>Lista de productos</h2>
        <%
            ArrayList<String> productos = (ArrayList<String>) request.getAttribute("lista_productos");
            if(productos != null && !productos.isEmpty()){
        %>
        
        <ul>
            <%for(String producto : productos){%>
            <li>
                <%= producto%>
            </li>
            <% } %>
        </ul>
        <%
            }
            else{
        %>
        
        <p>No hay productos disponibles0</p>
        
        <% } %>
        
        <h3>Modificar Producto</h3>
        <form action="SvEditarProducto" method="POST">
            <label for="id_producto">ID del producto: a modificar</label>
            <input type="number" name="id_producto", id="id_producto" required/>
            <br />
            
            <label for="nuevo_nombre_producto">Nuevo nombre:</label>
            <input type="text" name="nuevo_nombre_producto" id="nuevo_nombre_producto"/>
            <br />
            
            <label for="nuevo_precio_producto">Nuevo precio:</label>
            <input type="number" step="0.01" name="nuevo_precio_producto" id="nuevo_precio_producto"/>
            <br />
            
            <button type="submit">Modificar</button>
        </form>
    </body>
</html>
