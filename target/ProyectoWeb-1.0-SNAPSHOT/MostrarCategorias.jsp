<%-- 
    Document   : MostrarCategorias
    Created on : 3 oct. 2025, 13:38:58
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
        <title>Mostrar Categorias</title>
    </head>
    <body>
        <h2>Lista de Categorias</h2>
        
        <%
            List<Categoria> lista_categorias = (List<Categoria>)request.getAttribute("lista_categorias");
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
                        <td><%= categoria.getIdCategoria()%></td>
                        <td><%= categoria.getNombreCategoria()%></td>
                        <td>$<%= categoria.getDescripcion()%></td>
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
