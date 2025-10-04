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
        <link rel="stylesheet" type="text/css" href="css/estilos.css" />
        <meta name="author" content="Joshua Correa Herrera" />
        <meta name="description" content="Pagina Web y Sistema de Gestion de Tienda" />
        <meta name="keywords" content="Tienda, sistema, web, desarrollo, venta" />
        <meta name="copyright" content="Joshua Correa Herrera" />
        <title>Modificar Producto</title>
    </head>
    <body>
        <div class="container">
            <h2>Modificar Productos</h2>
            <p class="subtitle">Actualice la información de los productos existentes</p>

            <%
                String mensaje = (String) request.getAttribute("mensaje");
                if (mensaje != null) {
            %>
            <div class="mensaje">
                <%= mensaje%>
            </div>
            <% } %>

            <!-- Lista de productos para referencia -->
            <div style="margin-bottom: 30px;">
                <h3 style="color: #2c5530; margin-bottom: 15px;">Productos Disponibles (Referencia)</h3>
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
                            <th>Categoría ID</th>
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
                            <td><%= producto.getCategoriaId()%></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <%
                } else {
                %>
                <p class="no-data">No hay productos disponibles</p>
                <% }%>
            </div>

            <!-- Formulario de edición -->
            <div style="background: #f8f9fa; padding: 25px; border-radius: 8px; border: 1px solid #dee2e6;">
                <h3 style="color: #2c5530; margin-bottom: 20px; text-align: center;">Formulario de Modificación</h3>

                <form action="SvEditarProducto" method="POST" class="form-simple">
                    <div class="form-group">
                        <label for="id_producto" class="form-label">ID del producto a modificar:</label>
                        <input type="number" name="id_producto" id="id_producto" class="form-input" required />
                    </div>

                    <div class="form-group">
                        <label for="nuevo_nombre_producto" class="form-label">Nuevo nombre (dejar vacío para no cambiar):</label>
                        <input type="text" name="nuevo_nombre_producto" id="nuevo_nombre_producto" class="form-input" placeholder="Ej: Coca Cola 2L"/>
                    </div>

                    <div class="form-group">
                        <label for="nuevo_precio_producto" class="form-label">Nuevo precio (dejar 0 para no cambiar):</label>
                        <input type="number" step="0.01" name="nuevo_precio_producto" id="nuevo_precio_producto" class="form-input" value="0"/>
                    </div>

                    <div class="form-group">
                        <label for="nueva_cantidad_producto" class="form-label">Nueva cantidad (dejar 0 para no cambiar):</label>
                        <input type="number" name="nueva_cantidad_producto" id="nueva_cantidad_producto" class="form-input" value="0"/>
                    </div>

                    <div class="form-group">
                        <label for="nueva_categoria_id" class="form-label">Nueva categoría ID (dejar 0 para no cambiar):</label>
                        <input type="number" name="nueva_categoria_id" id="nueva_categoria_id" class="form-input" value="0"/>
                    </div>

                    <div class="form-group">
                        <label for="nueva_descripcion" class="form-label">Nueva descripción (dejar vacío para no cambiar):</label>
                        <textarea name="nueva_descripcion" id="nueva_descripcion" class="form-textarea" placeholder="Ej: Refresco de cola"></textarea>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-success">Modificar Producto</button>
                        <a href="Conexion.jsp" class="btn">Cancelar</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
