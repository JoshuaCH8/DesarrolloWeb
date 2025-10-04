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
<%@ page import="Logica.Producto" %>
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
        <title>Eliminar Producto</title>
    </head>
    <body>
        <div class="container">
            <h2>Eliminar Productos</h2>
            <p class="subtitle">Seleccione el producto que desea eliminar del sistema</p>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% } %>

            <%
                List<Producto> lista_productos = (List<Producto>) request.getAttribute("lista_productos");
                if (lista_productos != null && !lista_productos.isEmpty()) {
            %>
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Código Barras</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (Producto producto : lista_productos) {
                    %>
                    <tr>
                        <td><%= producto.getIdProducto()%></td>
                        <td><strong><%= producto.getNombreProducto()%></strong></td>
                        <td>$<%= producto.getPrecioProducto()%></td>
                        <td><%= producto.getCantidadProducto()%></td>
                        <td><%= producto.getCodigoBarras()%></td>
                        <td>
                            <form action="SvEliminarProducto" method="POST" style="display: inline;">
                                <input type="hidden" name="id_producto" value="<%= producto.getIdProducto()%>">
                                    <button type="submit" 
                                            onclick="return confirm('¿Está seguro de eliminar el producto: <%= producto.getNombreProducto()%>?')"
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
            <p class="no-data">No hay productos disponibles</p>
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
