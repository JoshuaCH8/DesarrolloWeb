<%-- 
    Document   : EditarCategoria
    Created on : 3 oct. 2025, 12:52:33
    Author     : sabri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Logica.ConexionDB"%>
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
        <title>Modificar Categoria</title>
    </head>
    <body>
        <h2>Lista de categorias</h2>

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
            List<Categoria> lista_categorias = (List<Categoria>) request.getAttribute("lista_categorias");
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
                        <td>$<%= categoria.getDescripcion()%></td>
                    </tr>
                <% } %>
            </table>
        <%
            } else {
        %>
            <p>No hay categorias disponibles</p>
        <% } %>  
        
        <h3>Modificar Categoria</h3>
        <form action="SvEditarCategoria" method="POST">
            <!-- Campo ID (OBLIGATORIO) -->
            <label for="id_categoria">ID de la Categoria a modificar:</label>
            <input type="number" name="id_categoria" id="id_categoria" required/>
            <br /><br />
        
            <!-- Campos OPCIONALES -->
            <label for="nuevo_nombre_categoria">Nuevo nombre (dejar vacío para no cambiar):</label>
            <input type="text" name="nuevo_nombre_categoria" id="nuevo_nombre_categoria" placeholder="Ej: Bebidas Azucaradas"/>
            <br />
        
            <label for="nueva_descripcion">Nueva descripción (dejar vacío para no cambiar):</label>
            <textarea name="nueva_descripcion" id="nueva_descripcion" placeholder="Ej: Bebidas altas en azucares"></textarea>
            <br />
        
            <button type="submit">Modificar Categoria</button>
        </form>
        
    <!-- Ruta Absoluta al inicio -->
    <a href="/prueba/Conexion.jsp">Regresar al Inicio</a>        
    </body>
</html>
