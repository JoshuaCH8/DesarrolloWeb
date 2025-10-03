<%-- 
    Document   : EliminarCategoria
    Created on : 3 oct. 2025, 12:33:26
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
<%@page import = "java.util.List" %>
<%@page import = "java.util.ArrayList" %>
<%@ page import="Logica.Categoria" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
    "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Eliminar Categoria</title>
    </head>
    <body>
        <h2>Lista de productos</h2>
    
    <%
        String mensaje = (String) request.getAttribute("mensaje");
        if (mensaje != null) {
    %>    
        <div style="color: blue; margin: 10px 0;">
            <%= mensaje %>
        </div>
    <% } %>
    <%
        List<Categoria> lista_categorias = (List<Categoria>) request.getAttribute("lista_categoria");
        if (lista_categorias != null && !lista_categorias.isEmpty()) {
    %>    
            <table border="1" style="width: 100%;">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripcion</th>
                </tr>
                <%
                    for (Categoria categoria : lista_categorias) {
                %>
                    <tr>
                        <td><%= categoria.getIdCategoria() %></td>
                        <td><%= categoria.getNombreCategoria() %></td>
                        <td>$<%= categoria.getDescripcion() %></td>
                        <td>
                            <form action="SvElminarCategoria" method="POST" style="display: inline;">
                                <input type="hidden" name="id_categoria" value="<%= categoria.getIdCategoria() %>">
                                <button type="submit" style="background: #dc3545; color: white; border: none; padding: 5px 10px; cursor: pointer;">
                                    Eliminar
                                </button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </table>
    <%
        } else {
    %>
        <p>No hay categorias disponibles</p>
    <% } %>
    <!-- Ruta Absoluta al inicio -->
    <a href="/prueba/Conexion.jsp">Regresar al Inicio</a>    
    </body>
</html>
