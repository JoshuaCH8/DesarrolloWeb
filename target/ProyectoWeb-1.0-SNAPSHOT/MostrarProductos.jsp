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
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Mostrar Productos</title>
    </head>
    <body>
        <div class="container">
            <h2>Inventario de Productos</h2>
            <p class="subtitle">Catálogo completo de productos disponibles en la tienda</p>

            <%
                List<Producto> lista_productos = (List<Producto>) request.getAttribute("lista_productos");
                if (lista_productos != null && !lista_productos.isEmpty()) {

                    // Calcular estadísticas
                    int totalProductos = lista_productos.size();
                    int totalStock = 0;
                    double valorTotal = 0.0;

                    for (Producto producto : lista_productos) {
                        totalStock += producto.getCantidadProducto();
                        valorTotal += producto.getPrecioProducto().doubleValue() * producto.getCantidadProducto();
                    }
            %>

            <!-- Estadísticas simplificadas -->
            <div class="mensaje" style="text-align: center; margin-bottom: 20px;">
                <p>
                    <strong>Total Productos: <%= totalProductos%> | 
                        En Stock: <%= totalStock%></strong>
                </p>
            </div>

            <!-- Tabla de productos -->
            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th>Código Barras</th>
                        <th>Categoría</th>
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
                        <td>
                            <%
                                int stock = producto.getCantidadProducto();
                                String estiloStock = "";
                                if (stock > 10) {
                                    estiloStock = "color: green;";
                                } else if (stock > 0) {
                                    estiloStock = "color: orange;";
                                } else {
                                    estiloStock = "color: red;";
                                }
                            %>
                            <span style="<%= estiloStock%> font-weight: bold;">
                                <%= stock%>
                            </span>
                        </td>
                        <td><%= producto.getCodigoBarras()%></td>
                        <td>#<%= producto.getCategoriaId()%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <%
            } else {
            %>
            <!-- Estado sin datos -->
            <div class="mensaje" style="text-align: center;">
                <p><strong>No hay productos disponibles</strong></p>
                <p>El inventario de productos está vacío.</p>
                <a href="AgregarProducto.jsp" class="btn btn-success">Agregar Primer Producto</a>
            </div>
            <% }%>

            <!-- Botón de regreso -->
            <div style="text-align: center; margin-top: 20px;">
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
