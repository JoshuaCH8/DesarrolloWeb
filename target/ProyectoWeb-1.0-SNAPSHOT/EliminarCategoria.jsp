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
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Eliminar Categoria</title>
    </head>
    <body>
        <div class="container">
            <!-- INCLUIR NAVBAR -->
            <%@include file="navbar.jsp" %>
            <h2>Eliminar Categorías</h2>
            <p class="subtitle">Seleccione la categoría que desea eliminar del sistema</p>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>    
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% } %>

            <%
                List<Categoria> lista_categorias = (List<Categoria>) request.getAttribute("lista_categorias");
                if (lista_categorias != null && !lista_categorias.isEmpty()) {
            %>    
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Categoria categoria : lista_categorias) {
                    %>
                    <tr>
                        <td><%= categoria.getIdCategoria()%></td>
                        <td><strong><%= categoria.getNombreCategoria()%></strong></td>
                        <td><%= categoria.getDescripcion()%></td>
                        <td>
                            <form action="SvEliminarCategoria" method="POST" style="display: inline;">
                                <input type="hidden" name="id_categoria" value="<%= categoria.getIdCategoria()%>">
                                    <button type="submit" 
                                            class="btn btn-danger btn-small">
                                        Eliminar
                                    </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <%
            } else {
            %>
            <p class="no-data">No hay categorías disponibles</p>
            <% }%>

            <div style="text-align: center; margin-top: 25px;">
                <a href="Conexion.jsp" class="btn">Volver al Inicio</a>
            </div>
        </div>

        <p>
            <a href="https://validator.w3.org/check?uri=referer"><img
                    src="https://www.w3.org/Icons/valid-xhtml11-blue" alt="Valid XHTML 1.1" height="31" width="88" /></a>
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
