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
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Mostrar Categorias</title>
    </head>
    <body>
        <div class="container">
            <h2>Catálogo de Categorías</h2>
            <p class="subtitle">Lista completa de categorías disponibles en el sistema</p>

            <%
                List<Categoria> lista_categorias = (List<Categoria>) request.getAttribute("lista_categorias");
                if (lista_categorias != null && !lista_categorias.isEmpty()) {
            %>
            <!-- Contador simple -->
            <div style="background: #e7f3ff; padding: 15px; border-radius: 5px; margin-bottom: 20px; text-align: center;">
                <p style="margin: 0; color: #004085;">
                    <strong>Total de categorías: <%= lista_categorias.size()%></strong>
                </p>
            </div>

            <!-- Tabla de categorías -->
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
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
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <%
            } else {
            %>
            <!-- Estado sin datos -->
            <div style="text-align: center; padding: 40px; background: #f8f9fa; border-radius: 8px;">
                <p style="color: #6c757d; font-size: 1.2em; margin-bottom: 20px;">
                    No hay categorías disponibles
                </p>
                <p style="color: #6c757d; margin-bottom: 25px;">
                    No se han registrado categorías en el sistema.
                </p>
                <a href="AgregarCategoria.jsp" class="btn btn-success">Agregar Primera Categoría</a>
            </div>
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
